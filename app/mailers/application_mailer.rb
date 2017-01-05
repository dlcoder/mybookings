class ApplicationMailer < ActionMailer::Base
  app_name = I18n.t('app_name')
  default from: "#{app_name} <#{MYBOOKINGS_CONFIG['notifications_mail']}>"
  layout 'email_layout'
end
