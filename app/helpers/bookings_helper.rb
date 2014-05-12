module BookingsHelper

  def booking_tr_class booking
    class_base = "booking-#{booking.id}"

    if booking.pending?
      "#{class_base} booking-pending"
    elsif booking.expired?
      "#{class_base} booking-expired success"
    elsif booking.occurring?
      "#{class_base} booking-occurring info"
    end
  end

end
