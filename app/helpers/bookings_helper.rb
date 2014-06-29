module BookingsHelper

  def status_for booking
    return t('bookings.statuses.pending') if booking.pending?
    return t('bookings.statuses.expired') if booking.expired?
    return t('bookings.statuses.occurring') if booking.occurring?
  end

  def bootstrap_class_for booking_status
    return 'warning' if booking_status == t('bookings.statuses.pending')
    return 'success' if booking_status == t('bookings.statuses.expired')
    return 'info' if booking_status == t('bookings.statuses.occurring')
  end

end
