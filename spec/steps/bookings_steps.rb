require 'spec_helper'

step 'I go to the bookings page' do
  visit '/bookings'
end

step 'I can book a resource' do
  click_link 'Book a resource'

  pending 'TODO: That test is failing. Resource is not been selected and submit sends empty resource.'
  select 'PCV1', from: 'Resource'
  # TODO: I don't know why fill_in is not working here.
  # fill_in 'Start date', with: '03/30/2014 9:00 AM'
  # fill_in 'End date', with: '03/30/2014 2:00 PM'
  page.execute_script("$('#booking_start_date').attr('value', '03/30/2014 9:00 AM')")
  page.execute_script("$('#booking_end_date').attr('value', '03/30/2014 2:00 PM')")

  click_button 'Create booking'
end

# step 'I can see that the booking has been created' do
#   within '.my_bookings_list' do
#     expect(page).to have_content('PCV1')
#   end
# end
