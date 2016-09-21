class ApplicationMailer < ActionMailer::Base
  default from: 'MyBookings <no-reply@mybookings.com>'
  layout 'email_layout'
end
