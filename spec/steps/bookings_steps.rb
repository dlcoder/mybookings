require 'spec_helper'

step 'I go to the bookings page' do
  visit '/bookings'
end

step 'I can book a resource' do
  click_link 'Book a resource'

  select 'PCV1', from: 'Resource'
  page.execute_script("$('#booking_start_date').attr('value', '30-03-2014 9:00')")
  page.execute_script("$('#booking_end_date').attr('value', '30-03-2014 14:00')")

  click_button 'Create booking'
end

# step 'I can see that the booking has been created' do
#   within '.my_bookings_list' do
#     expect(page).to have_content('PCV1')
#   end
# end
