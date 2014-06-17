require 'spec_helper'

step 'I go to the bookings page' do
  visit '/bookings'
end

step 'I go to the new booking page' do
  click_link 'Book a resource'
end

step 'I can not see a disabled resource for booking' do
  expect(page).not_to have_content('Disabled resource')
end

step 'I can book an available resource' do
  select 'PCV1', from: 'Resource'

  now = Time.now
  fill_in 'booking_start_date', with: (now + 1.day).strftime("%d-%m-%Y %H:%M")
  fill_in 'booking_end_date', with: (now + 2.day).strftime("%d-%m-%Y %H:%M")

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

step 'I click button to submit some feedback about expired booking' do
  within 'table#bookings tbody tr:first-child' do
    click_link 'Send feedback'
  end
end

step 'I can send a feedback message' do
  fill_in 'Feedback', with: 'The system was very slow.'

  click_button 'Send feedback'
end

step 'I can see that the feedback have been submitted' do
  expect(page).to have_content('Thanks. We have received your feedback.')

  within 'table#bookings tbody tr:first-child' do
    expect(page).to_not have_content('Send feedback')
  end
end
