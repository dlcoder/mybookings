require 'spec_helper'

step 'I go to the bookings page' do
  visit '/bookings'
end

step 'I can book a resource' do
  click_link 'Book a resource'

  fill_in 'Resource', with: 'Virtual PC'
  fill_in 'Start date', with: '03/30/2014  9:00 AM'
  fill_in 'End date', with: '2014-05-01 2:00 PM'

  #click_button 'Create booking'
end
