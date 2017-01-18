module Mybookings
  class NotificationsMailer < ApplicationMailer
    def cancel_event event, reason
      @event = event
      @reason = reason

      app_name = t('mybookings.app_name')
      notification_subject = t('mybookings.notifications_mailer.cancel_event.subject')

      mail(to: event.booking.user_email, subject: "[#{app_name}] #{notification_subject}")
    end

    def notify_upcoming_booking booking
      @booking = booking

      app_name = t('mybookings.app_name')
      notification_subject = t('mybookings.notifications_mailer.notify_upcoming_booking.subject')

      mail(to: booking.user_email, subject: "[#{app_name}] #{notification_subject}")
    end

    def notify_new_booking booking
      users = booking.resource_type_users
      return if users.empty?

      @resource_type_name = booking.resource_type_name

      app_name = t('mybookings.app_name')
      notification_subject = t('mybookings.notifications_mailer.notify_new_booking.subject')

      users.each do |user|
        mail(to: user.email, subject: "[#{app_name}] #{notification_subject}")
      end
    end

    def notify_delete_booking booking
      users = booking.resource_type_users
      return if users.empty?

      @resource_type_name = booking.resource_type_name

      app_name = t('mybookings.app_name')
      notification_subject = t('mybookings.notifications_mailer.notify_delete_booking.subject')

      users.each do |user|
        mail(to: user.email, subject: "[#{app_name}] #{notification_subject}")
      end
    end

  end
end
