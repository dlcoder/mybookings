module BookingsHelper

  def bootstrap_class_for booking_status
    return 'warning' if booking_status == 'pending'
    return 'info' if booking_status == 'occurring'
    return 'success' if booking_status == 'expired'
  end

end
