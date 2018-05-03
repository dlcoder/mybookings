module Mybookings
  class RemindersMailer < ApplicationMailer
    def upcoming_event_to_user(event)
      @event = event

      from = event.booking_resource_type_notifications_email_from
      from = MYBOOKINGS_CONFIG['default_notifications_email'] if from.blank?

      mail(
        from: from,
        to: event.booking_user_email,
        subject: subject(t('mybookings.reminders_mailer.upcoming_event_to_user.subject', resource_type_name: event.resource_resource_type_name)),
      )
    end
  end
end
