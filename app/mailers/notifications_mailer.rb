class NotificationsMailer < ApplicationMailer
  def cancel_booking booking, reason
    @booking = booking
    @reason = reason
    mail(to: booking.user_email, subject: t('notifications_mailer.cancel_booking.subject'))
  end

  def notify_upcoming_booking booking
    @booking = booking
    mail(to: booking.user_email, subject: t('notifications_mailer.notify_upcoming_booking.subject')).deliver
  end

  def notify_new_booking booking
    users = booking.resource.resource_type_users
    @resource_name = booking.resource_name

    users.each do |user|
      mail(to: user.email, subject: t('notifications_mailer.notify_new_booking.subject')).deliver
    end
  end

  def notify_delete_booking booking
    users = booking.resource.resource_type_users
    @resource_name = booking.resource_name

    users.each do |user|
      mail(to: user.email, subject: t('notifications_mailer.notify_delete_booking.subject')).deliver
    end
  end

end
