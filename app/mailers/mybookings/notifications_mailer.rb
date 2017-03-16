module Mybookings
  class NotificationsMailer < ApplicationMailer
    def cancel_event event, reason
      @event = event
      @reason = reason

      notification_subject = t('mybookings.notifications_mailer.cancel_event.subject')

      mail(from: from_email_for(event), to: event.booking_user_email, subject: "[#{app_name}] #{notification_subject}")
    end

    def notify_upcoming_booking booking
      @booking = booking

      notification_subject = t('mybookings.notifications_mailer.notify_upcoming_booking.subject')

      mail(from: from_email_for(booking), to: booking.user_email, subject: "[#{app_name}] #{notification_subject}")
    end

    def notify_new_booking booking
      destination_emails = booking.resource_type_notifications_emails
      return if destination_emails.empty?

      @params = params_for_new_booking_notification(booking)

      subject = "[#{app_name}] #{t('mybookings.notifications_mailer.notify_new_booking.subject',
        resource_type_name: @params[:resource_type_name],
        user_email: @params[:user_email]
      )}"

      destination_emails.each do |email|
        mail(from: from_email_for(booking), to: email, subject: subject)
      end
    end

    def notify_delete_booking booking
      emails = booking.resource_type_notifications_emails
      return if emails.empty?

      @resource_type_name = booking.resource_type_name

      notification_subject = t('mybookings.notifications_mailer.notify_delete_booking.subject')

      emails.each do |email|
        mail(from: from_email_for(booking), to: email, subject: "[#{app_name}] #{notification_subject}")
      end
    end

    private

    def from_email_for resource
      email = resource.resource_type_notifications_email_from if resource.is_a? Booking
      email = resource.booking_resource_type_notifications_email_from if resource.is_a? Event

      return email unless email.nil?
      return MYBOOKINGS_CONFIG['default_notifications_email']
    end

    def app_name
      t('mybookings.app_name')
    end

    def params_for_new_booking_notification booking
      params_events = []

      booking.events.each do |event|
        params_events.push({
          resource_name: event.resource_name,
          start_date: event.start_date,
          end_date: event.end_date
        })
      end

      params = {
        user_email: booking.user_email,
        resource_type_name: booking.resource_type_name,
        booking_date: booking.created_at,
        comment: booking.comment,
        events: params_events
      }

      params
    end
  end
end
