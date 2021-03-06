module Mybookings
  class Event < ApplicationRecord
    include Loggable

    acts_as_paranoid

    belongs_to :booking
    belongs_to :resource

    before_validation :precalculate_advanced_and_delayed_dates

    validates :start_date, :end_date, :resource, presence: true
    validate :dates_range
    validate :dates_in_the_future, :dates_ovelap, :resource_is_available, on: :create

    delegate :name, :resource_type_name, :resource_type_extension, to: :resource, prefix: true
    delegate :user_email, :resource_type_notifications_email_from, :resource_type_limit_days_for_feedback, :resource_type_minutes_in_advance, to: :booking, prefix: true

    enum status: %w(pending occurring expired)

    self.inheritance_column = :event_type

    def self.upcoming
      Event.pending.where('? >= start_date_advanced', Time.now)
    end

    def self.finished
      Event.occurring.where('? >= end_date_delayed', Time.now)
    end

    def self.overlapped_with event
      start_date_modified = event.start_date_advanced - MYBOOKINGS_CONFIG['minutes_between_cron_runs'].minutes
      end_date_modified = event.end_date_delayed + MYBOOKINGS_CONFIG['minutes_between_cron_runs'].minutes

      where('(? >= start_date_advanced AND ? <= end_date_delayed) OR (? >= start_date_advanced AND ? <= end_date_delayed)',
        start_date_modified, start_date_modified, end_date_modified, end_date_modified)
    end

    def self.recents
      where(status: statuses[:expired]).last(statuses[:expired]) | where.not(status: statuses[:expired])
    end

    def self.not_pending
      where.not(status: statuses[:expired])
    end

    def self.by_resource resource
      where(resource: resource)
    end

    def self.for_user user
      joins(:booking).where('mybookings_bookings.user_id = ?', user.id)
    end

    def self.between start_date, end_date
      where(start_date: start_date..end_date)
    end

    def alternative_resources
      resource_type_id = self.resource.resource_type.id

      # Enabled resources of the same type that overlaps with self booking
      resources_with_overlapped_events = Event.overlapped_with(self)
        .joins(:resource)
        .where(mybookings_resources: { resource_type_id: resource_type_id, disabled: false })
        .pluck('mybookings_resources.id')

      # Add self event resource to exclude it
      resources_with_overlapped_events.push(self.resource.id)

      Resource.where(resource_type_id: resource_type_id, disabled: false).where.not(id: resources_with_overlapped_events)
    end

    def cancel!; end

    def start!
      occurring!
    end

    def end!
      expired!
    end

    private

    def precalculate_advanced_and_delayed_dates
      self.start_date_advanced = start_date - booking.resource_type_minutes_in_advance.minutes
      self.end_date_delayed = end_date + booking.resource_type_minutes_of_grace.minutes
    end

    def dates_in_the_future
      unless start_date.nil?
        errors.add(:start_date, I18n.t('errors.messages.event.start_date_in_the_past')) if start_date.past?
      end

      unless end_date.nil?
        errors.add(:end_date, I18n.t('errors.messages.event.end_date_in_the_past')) if end_date.past?
      end
    end

    def dates_range
      unless start_date.nil? or end_date.nil?
        if end_date <= start_date
          errors.add(:start_date, I18n.t('errors.messages.event.start_date_greater_than_end_date'))
          errors.add(:end_date, I18n.t('errors.messages.event.end_date_smaller_than_start_date'))
        end
      end
    end

    def dates_ovelap
      return if start_date.nil? or end_date.nil? or resource.nil?

      start_date_modified = start_date_advanced - MYBOOKINGS_CONFIG['minutes_between_cron_runs'].minutes
      end_date_modified = end_date_delayed + MYBOOKINGS_CONFIG['minutes_between_cron_runs'].minutes

      overlapped_events = resource.events.where(
        '(mybookings_events.start_date >= ? AND mybookings_events.start_date <= ?) OR
        (mybookings_events.end_date >= ? AND mybookings_events.end_date <= ?) OR
        (mybookings_events.start_date >= ? AND mybookings_events.end_date <= ?) OR
        (mybookings_events.start_date <= ? AND mybookings_events.end_date >= ?)',
        start_date_modified, end_date_modified,
        start_date_modified, end_date_modified,
        start_date_modified, end_date_modified,
        start_date_modified, end_date_modified
      )

      if overlapped_events.any?
        errors.add(:base, I18n.t('errors.messages.event.overlap', start_date: I18n.l(start_date, format: :very_long)))
      end
    end

    def resource_is_available
      unless resource.nil?
        errors.add(:resource, I18n.t('errors.messages.event.resource_is_not_available')) if resource.disabled?
      end
    end
  end
end
