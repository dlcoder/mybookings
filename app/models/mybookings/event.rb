module Mybookings
  class Event < ActiveRecord::Base
    include Loggable

    belongs_to :booking
    belongs_to :resource

    validates :start_date, :end_date, :resource, presence: true
    validate :dates_range
    validate :dates_in_the_future, :dates_ovelap, :resource_is_available, on: :create

    delegate :name, to: :resource, prefix: true
    delegate :resource_type_name, to: :resource, prefix: true
    delegate :resource_type_extension, to: :resource, prefix: true

    enum status: %w(pending occurring expired)

    def self.upcoming
      Event.pending.where('? >= start_date', Time.now + MYBOOKINGS_CONFIG['extensions_trigger_frequency'].minutes)
    end

    def self.finished
      Event.occurring.where('? >= end_date', Time.now)
    end

    def self.overlapped_at start_date, end_date
      # Dates extended to trigger frequency
      start_date = start_date - MYBOOKINGS_CONFIG['extensions_trigger_frequency'].minutes
      end_date = end_date + MYBOOKINGS_CONFIG['extensions_trigger_frequency'].minutes

      where('(? >= start_date AND ? <= end_date) OR (? >= start_date AND ? <= end_date)', start_date, start_date, end_date, end_date)
    end

    def alternative_resources
      resource_type_id = self.resource.resource_type.id

      # Enabled resources of the same type that overlaps with self booking
      resources_with_overlapped_events = Event.overlapped_at(self.start_date, self.end_date)
        .joins(:resource)
        .where(mybookings_resources: { resource_type_id: resource_type_id, disabled: false })
        .pluck('mybookings_resources.id')

      # Add self event resource to exclude it
      resources_with_overlapped_events.push(self.resource.id)

      Resource.where(resource_type_id: resource_type_id, disabled: false).where.not(id: resources_with_overlapped_events)
    end

    def self.recents
      where(status: statuses[:expired]).last(statuses[:expired]) | where.not(status: statuses[:expired])
    end

    def self.active_by_resource_between resource, start_day, end_day
      where(resource: resource, start_date: start_day..end_day).where.not(status: statuses[:expired])
    end

    def cancel!; end

    def start!
      occurring!
    end

    def end!
      expired!
    end

    private

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

      start_date_modified = start_date - MYBOOKINGS_CONFIG['extensions_trigger_frequency'].minutes
      end_date_modified = end_date + MYBOOKINGS_CONFIG['extensions_trigger_frequency'].minutes

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
