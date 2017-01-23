module Mybookings
  class BookingsForm
    include ActiveModel::Validations

    attr_accessor :resource, :start_date, :end_date, :comment, :resource_type_id, :type, :until_date

    TYPES = %w(weekly monthly)

    validates :resource, :start_date, :end_date, presence: true
    validates :until_date, presence: true, if: :is_an_recurring_booking?
    validate :the_booking_period_is_valid, if: :is_an_recurring_booking?
    validate :the_event_duration_is_valid

    def initialize params={}
      self.resource = params[:resource]
      self.start_date = params[:start_date]
      self.end_date = params[:end_date]
      self.comment = params[:comment]
      self.resource_type_id = params[:resource_type_id]
      self.type = params[:type]
      self.until_date = params[:until_date]
    end

    def to_key; nil; end

    def resource_type
      ResourceType.find(self.resource_type_id)
    end

    def eventuallity
      return type.nil? ? "daily": type
    end

    private

    def is_an_recurring_booking?
      !type.nil?
    end

    def the_booking_period_is_valid
      booking_interval = until_date.to_datetime - start_date.to_datetime
      range_permitted = MYBOOKINGS_CONFIG['maximum_permitted_days_for_recurring_events']
      if  range_permitted.days - booking_interval.days < 0
        errors.add(:until_date, I18n.t('.mybookings.bookings.new_booking_events_step.dates_interval_message_error', days_permitted: range_permitted))
      end
    end

    def the_event_duration_is_valid
      event_duration_in_seconds = end_date.to_time - start_date.to_time
      permitted_event_duration_in_seconds = MYBOOKINGS_CONFIG['maximum_duration_in_hours_for_an_event'] * 3600
      if event_duration_in_seconds > permitted_event_duration_in_seconds
        errors.add(:base, I18n.t('.mybookings.bookings.new_booking_events_step.event_duration_message_error', event_duration: MYBOOKINGS_CONFIG['maximum_duration_in_hours_for_an_event']))
      end
    end

  end
end
