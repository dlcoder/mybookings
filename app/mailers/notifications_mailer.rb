class NotificationsMailer < ApplicationMailer
  def cancel_booking booking, reason
    @booking = booking
    @reason = reason

    app_name = t('app_name')
    notification_subject = t('notifications_mailer.cancel_booking.subject')

    mail(to: booking.user_email, subject: "[#{app_name}] #{notification_subject}")
  end

  def notify_upcoming_booking booking
    @booking = booking

    app_name = t('app_name')
    notification_subject = t('notifications_mailer.notify_upcoming_booking.subject')

    mail(to: booking.user_email, subject: "[#{app_name}] #{notification_subject}")
  end

  def notify_new_booking booking
    users = booking.resource_type_users
    return if users.empty?

    @resource_type_name = booking.resource_type_name

    app_name = t('app_name')
    notification_subject = t('notifications_mailer.notify_new_booking.subject')

    users.each do |user|
      mail(to: user.email, subject: "[#{app_name}] #{notification_subject}")
    end
  end

  def notify_delete_booking booking
    users = booking.resource_type_users
    return if users.empty?

    @resource_type_name = booking.resource_type_name

    app_name = t('app_name')
    notification_subject = t('notifications_mailer.notify_delete_booking.subject')

    users.each do |user|
      mail(to: user.email, subject: "[#{app_name}] #{notification_subject}")
    end
  end

end
