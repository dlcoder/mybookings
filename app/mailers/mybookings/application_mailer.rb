module Mybookings
  class ApplicationMailer < ActionMailer::Base
    app_name = I18n.t('mybookings.app_name')
    default from: "#{app_name} <#{MYBOOKINGS_CONFIG['default_notifications_email']}>"
    layout 'mybookings/email_layout'
  end
end
