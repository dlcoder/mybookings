module Mybookings
  class NotificationsMailer < ApplicationMailer
    def cancel_event event, reason
      @event = event
      @reason = reason

      app_name = t('mybookings.app_name')
      notification_subject = t('mybookings.notifications_mailer.cancel_event.subject')

      mail(from: notifications_email_from(event), to: event.booking_user_email, subject: "[#{app_name}] #{notification_subject}")
    end

    def notify_upcoming_booking booking
      @booking = booking

      app_name = t('mybookings.app_name')
      notification_subject = t('mybookings.notifications_mailer.notify_upcoming_booking.subject')

      mail(from: notifications_email_from(booking), to: booking.user_email, subject: "[#{app_name}] #{notification_subject}")
    end

    def notify_new_booking booking
      emails = booking.resource_type_notifications_emails
      return if emails.empty?

      @resource_type_name = booking.resource_type_name

      app_name = t('mybookings.app_name')
      notification_subject = t('mybookings.notifications_mailer.notify_new_booking.subject')

      emails.each do |email|
        mail(from: notifications_email_from(booking), to: email, subject: "[#{app_name}] #{notification_subject}")
      end
    end

    def notify_delete_booking booking
      emails = booking.resource_type_notifications_emails
      return if emails.empty?

      @resource_type_name = booking.resource_type_name

      app_name = t('mybookings.app_name')
      notification_subject = t('mybookings.notifications_mailer.notify_delete_booking.subject')

      emails.each do |email|
        mail(from: notifications_email_from(booking), to: email, subject: "[#{app_name}] #{notification_subject}")
      end
    end

    private

    def notifications_email_from resource
      email = resource.resource_type_notifications_email_from if resource.is_a? Booking
      email = resource.booking_resource_type_notifications_email_from if resource.is_a? Event

      return email unless email.nil?
      return MYBOOKINGS_CONFIG['default_notifications_email']
    end
  end
end
