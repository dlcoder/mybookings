require 'spec_helper'

step 'I go to the bookings page' do
  visit '/bookings'
end

step 'I can see that I have no bookings' do
  expect(page).to have_content('You does not have any booking yet.')
end

step 'I can book a resource' do
  click_link 'Book a resource'

  select 'PCV1', from: 'Resource'
  fill_in 'booking_start_date', with: '30-03-2014 9:00'
  fill_in 'booking_end_date', with: '30-03-2014 14:00'

  click_button 'Create booking'
end

step 'I can see that the booking has been created' do
  within 'table#bookings' do
    expect(page).to have_content('PCV1')
  end
end

step 'I can see my bookings summary' do
  expect(page).to have_selector('table#bookings')
end

step 'I cancel the booking' do
  within 'table#bookings tbody tr:first-child' do
    click_link 'Cancel'
  end
end

step 'I can see that the booking does not exists' do
  expect(page).to_not have_content('PCV1')
end
