class CreatesBooking

  def self.from_booking_params booking_params
    booking = Booking.new(booking_params)
    booking.resource = Resource.find(booking_params[:resource_id])
    booking.save!
  end

end
