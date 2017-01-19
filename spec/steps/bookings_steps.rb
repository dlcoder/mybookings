require 'rails_helper'

step 'I go to the bookings page' do
  visit '/bookings'
end

step 'I go to the new booking page' do
  click_link 'Book a resource'
end

step 'I can see the available resource types' do
  click_link 'Virtual PC'
end

step 'I can not see a disabled resource for booking' do
  expect(page).not_to have_content('Disabled resource')
end

step 'I can book an available resource' do
  select 'PCV1', from: 'Resource'

  now = Time.now
  fill_in 'bookings_form_start_date', with: (now + 1.day).strftime("%d-%m-%Y %H:%M")
  fill_in 'bookings_form_end_date', with: (now + 2.day).strftime("%d-%m-%Y %H:%M")
  fill_in 'Comment', with: 'I need that resource just in time.'

  click_button 'Create booking'
end

step 'I can see that the booking has been created' do
  expect(page).to have_content('Virtual PC')

  within '.resource-type-virtual-pc' do
    time = Time.now
    time -= 1.hour

    expect(page).to have_content("Booking created at #{time.strftime("%B %d, %Y %H:%M")}")
  end
end

step 'the manager should receive an email to notify the creation' do
  user = mybookings_users(:manager)

  expect(unread_emails_for(user.email).size).to eq(1)

  open_last_email_for(user.email)

  expect(current_email.subject).to include('A new booking has been created')
end

step 'I can see my bookings summary' do
  expect(page).to have_selector('.resource-type-virtual-pc')
end

step 'I cancel the booking' do
  within '.resource-type-virtual-pc' do
    click_link 'Cancel booking'
  end
end

step 'I can see that the booking does not exists' do
  expect(page).to_not have_content('Virtual PC')
end

step 'the manager should receive an email to notify the cancelation' do
  user = mybookings_users(:manager)

  expect(unread_emails_for(user.email).size).to eq(1)

  open_last_email_for(user.email)

  expect(current_email.subject).to include('A booking has been canceled')
end

step 'I click button to submit some feedback about an expired booking' do
  @event = mybookings_events(:event1)
  within "#event-#{@event.id}" do
    click_link 'Send feedback'
  end
end

step 'I can send a feedback message' do
  fill_in 'Feedback', with: 'The system was very slow.'

  click_button 'Send feedback'
end

step 'I can see that the feedback have been submitted' do
  expect(page).to have_content('Thanks. We have received your feedback.')
  expect(find("#event-#{@event.id}")).to_not have_content('Send feedback')
end

step 'I can book an available resource with weekly periodicity' do
  select 'PCV1', from: 'Resource'

  now = Time.now
  fill_in 'bookings_form_start_date', with: (now + 1.hour).strftime("%d-%m-%Y %H:%M")
  fill_in 'bookings_form_end_date', with: (now + 3.hours).strftime("%d-%m-%Y %H:%M")
  choose 'Weekly'
  fill_in 'bookings_form_until_date', with: (now + 3.weeks).strftime("%d-%m-%Y %H:%M")
  fill_in 'Comment', with: 'I have to create this weekly booking for my practices.'

  click_button 'Create booking'
end
