class BookingsMailer < ApplicationMailer
  def cancel_booking booking, reason
    @booking = booking
    @reason = reason
    mail(to: booking.user_email, subject: t('bookings_mailer.cancel_booking.subject'))
  end
end
