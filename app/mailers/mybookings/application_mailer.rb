module Mybookings
  class ApplicationMailer < ActionMailer::Base
    layout 'mybookings/email_layout'

    default from: "#{I18n.t('mybookings.app_name')} <#{MYBOOKINGS_CONFIG['default_notifications_email']}>"

    private

    def subject(text)
      "[#{I18n.t('mybookings.app_name')}] #{text}"
    end
  end
end
