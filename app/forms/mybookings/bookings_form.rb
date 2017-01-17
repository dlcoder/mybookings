module Mybookings
  class BookingsForm
    include ActiveModel::Validations

    attr_accessor :resource, :start_date, :end_date, :comment, :resource_type_id, :weekly, :monthly, :until_date

    validates :resource, :start_date, :end_date, presence: true
    validates :until_date, presence: true, if: :is_an_recurring_booking?
    validate :the_booking_period_is_valid, if: :is_an_recurring_booking?

    def initialize params={}
      self.resource = params[:resource]
      self.start_date = params[:start_date]
      self.end_date = params[:end_date]
      self.comment = params[:comment]
      self.resource_type_id = params[:resource_type_id]
      self.weekly = params[:weekly]
      self.monthly = params[:monthly]
      self.until_date = params[:until_date]
    end

    def to_key; nil; end

    def resource_type
      ResourceType.find(self.resource_type_id)
    end

    def is_an_recurring_booking?
      weekly == "0" && monthly == "0" ? false : true
    end

    def is_an_weekly_recurring_booking?
      weekly != "0"
    end

    def type
      type = ""

      if is_an_recurring_booking?
        if is_an_weekly_recurring_booking?
          type << "Weekly"
        else
          type << "Monthly"
        end
      end

      type
    end

    private

    def the_booking_period_is_valid
      booking_interval = until_date.to_datetime - start_date.to_datetime
      range_permitted = MYBOOKINGS_CONFIG['permitted_date_range_for_recurring_events']
      if  range_permitted.days - booking_interval.days < 0
        errors.add(:until_date, I18n.t('.bookings.new_booking_events_step.dates_interval_message_error', days_permitted: range_permitted))
      end
    end

  end
end
