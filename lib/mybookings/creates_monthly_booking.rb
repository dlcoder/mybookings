module Mybookings
  class CreatesMonthlyBooking

    def self.from_form owner, booking_form
      booking = Booking.new_for_user(owner, { resource_type: booking_form.resource_type, comment: booking_form.comment })

      booking.add_events(generate_events(booking_form))
      booking
    end

    private

    def self.generate_events booking_form
      resource = Resource.find(booking_form.resource)
      dates = generate_dates(booking_form.start_date.to_datetime, booking_form.end_date.to_datetime, booking_form.until_date.to_datetime)
      events = Array.new()

      dates.each do |date|
        events << Event.new(start_date: date.first, end_date: date.last, resource: resource)
      end

      events
    end

    def self.generate_dates start_date, end_date, until_date
      dates = Array.new

      while start_date <= until_date
        dates << [start_date.strftime("%d-%m-%Y %H:%M"), end_date.strftime("%d-%m-%Y %H:%M")]
        start_date += 1.month
        end_date += 1.month
      end

      dates
    end

  end
end
