class Booking < ActiveRecord::Base
  include Loggable

  belongs_to :user
  belongs_to :resource
  has_many :events , inverse_of: :booking

  accepts_nested_attributes_for :events

  enum status: %w(pending occurring expired)

  validate :resource, presence: true
  validate :resource_is_available, on: :create

  delegate :email, to: :user, prefix: true
  delegate :name, to: :resource, prefix: true
  delegate :resource_type_name, to: :resource, prefix: true
  delegate :resource_type_extension, to: :resource, prefix: true

  def self.by_start_date
    includes(:events).order('events.start_date DESC')
  end

  def self.new_for_user user, params
    booking = Booking.new(params)
    booking.user = user

    booking
  end

  def self.about_to_begin
    Booking.pending.where('? >= start_date', Time.now + MYBOOKINGS_CONFIG['extensions_trigger_frequency'].minutes)
  end

  def self.recently_finished
    Booking.occurring.where('? >= end_date', Time.now)
  end

  def self.overlapped_at start_date, end_date
    # Dates extended to trigger frequency
    start_date = start_date - MYBOOKINGS_CONFIG['extensions_trigger_frequency'].minutes
    end_date = end_date + MYBOOKINGS_CONFIG['extensions_trigger_frequency'].minutes

    where('(? >= start_date AND ? <= end_date) OR (? >= start_date AND ? <= end_date)', start_date, start_date, end_date, end_date)
  end

  def alternative_resources
    # Enabled resources of the same type that overlaps with self booking
    resources_with_overlapped_bookings = Booking.overlapped_at(self.start_date, self.end_date)
      .joins(:resource)
      .where(resources: { resource_type_id: resource.resource_type_id, disabled: false })
      .pluck('resources.id')

    # Add self booking resource to exclude it
    resources_with_overlapped_bookings.push(resource.id)

    Resource.where.not(id: resources_with_overlapped_bookings)
  end

  def self.upcoming
    start_date = Time.now + MYBOOKINGS_CONFIG['bookings_notifications_interval'].minutes
    end_date = start_date + MYBOOKINGS_CONFIG['extensions_trigger_frequency'].minutes
    Booking.pending.where('? >= start_date AND ? < start_date', start_date, end_date)
  end

  def log_for_record_created name, datetime
    Rails.logger.info "#{name} - New #{self.class.name} (#{self.id}) of #{self.resource_name} (#{self.resource_resource_type_name}) by user #{self.user_email} at #{datetime}."
  end

  private

  def resource_is_available
    unless resource.nil?
      errors.add(:resource, I18n.t('errors.messages.booking.resource_is_not_available')) if resource.disabled?
    end
  end
end
