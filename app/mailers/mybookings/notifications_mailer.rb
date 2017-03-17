module Mybookings
  class NotificationsMailer < ApplicationMailer
    def cancel_event event, reason
      @params = params_for_cancel_event_notification(event, reason)

      subject = "[#{app_name}] #{t('mybookings.notifications_mailer.cancel_event.subject')}"

      mail(from: from_email_for(event), to: event.booking_user_email, subject: subject)
    end

    def delete_booking booking
      destination_emails = booking.resource_type_notifications_emails
      return if destination_emails.empty?

      @params = params_for_delete_booking_notification(booking)

      subject = "[#{app_name}] #{t('mybookings.notifications_mailer.delete_booking.subject',
        resource_type_name: @params[:resource_type_name],
        user_email: @params[:user_email]
      )}"

      destination_emails.each do |email|
        mail(from: from_email_for(booking), to: email, subject: subject)
      end
    end

    def new_booking booking
      destination_emails = booking.resource_type_notifications_emails
      return if destination_emails.empty?

      @params = params_for_new_booking_notification(booking)

      subject = "[#{app_name}] #{t('mybookings.notifications_mailer.new_booking.subject',
        resource_type_name: @params[:resource_type_name],
        user_email: @params[:user_email]
      )}"

      destination_emails.each do |email|
        mail(from: from_email_for(booking), to: email, subject: subject)
      end
    end

    def upcoming_event event
      @params = params_for_upcoming_event(event)

      subject = "[#{app_name}] #{t('mybookings.notifications_mailer.upcoming_event.subject')}"

      mail(from: from_email_for(event), to: event.booking_user_email, subject: subject)
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

    def params_for_cancel_event_notification event, reason
      params = {
        cancelation_reason: reason,
        end_date: event.end_date,
        event_id: event.id,
        resource_name: event.resource_name,
        resource_type_name: event.resource_resource_type_name,
        start_date: event.start_date,
      }
    end

    def params_for_delete_booking_notification booking
      params = {
        booking_id: booking.id,
        resource_type_name: booking.resource_type_name,
        user_email: booking.user_email,
      }
    end

    def params_for_new_booking_notification booking
      params_events = []

      booking.events.each do |event|
        params_events.push({
          end_date: event.end_date,
          event_id: event.id,
          resource_name: event.resource_name,
          start_date: event.start_date,
        })
      end

      params = {
        booking_date: booking.created_at,
        booking_id: booking.id,
        comment: booking.comment,
        events: params_events,
        resource_type_name: booking.resource_type_name,
        user_email: booking.user_email,
      }
    end

    def params_for_upcoming_event event
      params = {
        end_date: event.end_date,
        event_id: event.id,
        resource_name: event.resource_name,
        resource_type_name: event.resource_resource_type_name,
        start_date: event.start_date,
      }
    end
  end
end
