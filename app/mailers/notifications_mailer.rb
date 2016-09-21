class NotificationsMailer < ApplicationMailer
  def cancel_booking booking, reason
    @booking = booking
    @reason = reason
    mail(to: booking.user_email, subject: t('notifications_mailer.cancel_booking.subject'))
  end

  def notify_upcoming_booking booking
    @booking = booking
    mail(to: booking.user_email, subject: t('notifications_mailer.notify_upcoming_booking.subject'))
  end
end
