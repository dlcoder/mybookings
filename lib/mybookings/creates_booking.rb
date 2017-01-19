module Mybookings
  class CreatesBooking

    def self.from_form owner, booking_form
      booking = Booking.new_for_user(owner, { resource_type: booking_form.resource_type, comment: booking_form.comment })

      booking.add_events(generate_events(booking_form))
      booking
    end

    private

    def self.generate_events booking_form
      resource = Resource.find(booking_form.resource)
      dates = generate_dates(booking_form.start_date.to_datetime,
                             booking_form.until_date.to_datetime,
                             self.send(booking_form.eventuallity))
      events = Array.new()

      event_duration = booking_form.end_date.to_datetime - booking_form.start_date.to_datetime

      dates.each do |date|
        events << Event.new(start_date: string_format(date),
                            end_date: string_format(date + event_duration),
                            resource: resource)
      end

      events
    end

    def self.generate_dates start_date, until_date, increment
      until_date = start_date if until_date.nil?

      dates = Array.new

      while start_date <= until_date
        dates << start_date
        start_date += increment
      end

      dates
    end

    def self.daily
      return 1.day
    end

    def self.weekly
      return 1.week
    end

    def self.monthly
      return 1.month
    end

    def self.string_format date
      date.strftime("%d-%m-%Y %H:%M")
    end
  end
end
