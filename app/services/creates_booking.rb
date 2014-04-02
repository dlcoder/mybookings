class CreatesBooking

  def self.from_booking_form booking_form
    booking = Booking.new(start_date: booking_form.start_date, end_date: booking_form.end_date)
    booking.resource = Resource.find booking_form.resource_id
    booking.save!
  end

end
