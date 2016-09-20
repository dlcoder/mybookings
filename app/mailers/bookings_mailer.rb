class BookingsMailer < ApplicationMailer
<<<<<<< HEAD
  def cancel_booking booking, reason
    @booking = booking
    @reason = reason
    mail(to: booking.user_email, subject: t('bookings_mailer.cancel_booking.subject'))
  end
=======
  def notify_upcoming_booking booking
    @booking = booking
    mail(to: booking.user_email, subject: t('bookings_mailer.notify_upcoming_booking.subject'))
  end

>>>>>>> Adds notification to the user for upcoming bookings.
end
