class BookingsMailer < ApplicationMailer

  def cancel_booking booking, reason
    @reason = reason
    @booking = booking
    mail(to: booking.user_email, subject: t('bookings_mailer.cancel_booking.subject'))
  end


end
