class CreatesBooking

  def self.from_booking_params booking_params
    booking = Booking.new(booking_params)

    resource_id = booking_params[:resource_id]
    unless resource_id.blank? then
      booking.resource = Resource.find(resource_id)
      booking.save!
    end

    booking
  end

end
