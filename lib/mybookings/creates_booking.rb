module Mybookings
  class CreatesBooking

    def self.from_form owner, booking_form
      booking = Booking.new_for_user(owner, { resource_type: booking_form.resource_type, comment: booking_form.comment })
      resource = Resource.find(booking_form.resource)
      event = Event.new(start_date: booking_form.start_date, end_date: booking_form.end_date, resource: resource)
      booking.add_event(event)
      booking
    end
  end
end
