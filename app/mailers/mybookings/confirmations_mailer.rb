module Mybookings
  class ConfirmationsMailer < ApplicationMailer
    def new_booking_to_user(booking)
      @booking = booking

      from = booking.resource_type_notifications_email_from
      from = MYBOOKINGS_CONFIG['default_notifications_email'] if from.blank?

      mail(
        from: from,
        to: booking.user_email,
        subject: subject(t('mybookings.confirmations_mailer.new_booking_to_user.subject', resource_type_name: booking.resource_type_name)),
      )
    end

    def new_booking_to_resource_type_managers(booking)
      @booking = booking

      from = booking.resource_type_notifications_email_from
      from = MYBOOKINGS_CONFIG['default_notifications_email'] if from.blank?

      mail(
        from: from,
        to: booking.resource_type_notifications_emails,
        subject: subject(t('mybookings.confirmations_mailer.new_booking_to_resource_type_managers.subject', resource_type_name: booking.resource_type_name)),
      )
    end
  end
end
