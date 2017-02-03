require 'rails_helper'

step 'I go to the bookings page' do
  visit '/bookings'
end

step 'I can book resources without role restrictions' do
  expect(page).to have_content('Resource type for all users')
  expect(page).not_to have_content('Virtual PC')
end

step 'I can start to create a booking' do
  within '.btn-group' do
    click_link 'Virtual PC'
  end
end

step 'I cannot see a disabled resource for booking' do
  expect(page).not_to have_content('Disabled resource')
end

step 'I cannot book an available resource for more than 4 hours' do
  select 'PCV1', from: 'Resource'

  now = Time.now
  fill_in 'booking_start_date', with: (now + 1.hour).strftime("%d-%m-%Y %H:%M")
  fill_in 'booking_end_date', with: (now + 5.hours + 1.minute).strftime("%d-%m-%Y %H:%M")

  click_button 'Create booking'

  expect(page).to have_content("It is not allowed to create bookings whose duration exceeds 4 hours.")
end

step 'I can book an available resource' do
  select 'PCV1', from: 'Resource'

  now = Time.now
  fill_in 'booking_start_date', with: (now + 1.hour).strftime("%d-%m-%Y %H:%M")
  fill_in 'booking_end_date', with: (now + 3.hours).strftime("%d-%m-%Y %H:%M")
  fill_in 'Comment', with: 'I need that resource just in time.'

  click_button 'Create booking'
end

step 'I can see that the booking has been created' do
  expect(page).to have_content('Virtual PC')

  within '.resource-type-virtual-pc' do
    expect(page).to have_content("Booking created at")
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
  within '.bookings-list' do
    expect(page).to_not have_content('Virtual PC')
  end
end

step 'the manager should receive an email to notify the cancelation' do
  user = mybookings_users(:manager)

  expect(unread_emails_for(user.email).size).to eq(1)

  open_last_email_for(user.email)

  expect(current_email.subject).to include('A booking has been canceled')
end

step 'I cannot see the feedback button in an old expired event' do
  event = mybookings_events(:event1)

  expect(find("#event-#{event.id}")).to_not have_content('Send feedback')
end

step 'I click button to submit some feedback about a recently expired booking' do
  event = mybookings_events(:event1)

  event.end_date = (Time.now - 3.days).strftime("%d-%m-%Y %H:%M")
  event.save!
  visit current_path

  within "#event-#{event.id}" do
    click_link 'Send feedback'
  end
end

step 'I can send a feedback message' do
  fill_in 'Feedback', with: 'The system was very slow.'

  click_button 'Send feedback'
end

step 'I can see that the feedback have been submitted' do
  event = mybookings_events(:event1)

  expect(page).to have_content('Thanks. We have received your feedback.')
  expect(find("#event-#{event.id}")).to_not have_content('Send feedback')
end

step 'I can book an available resource with weekly periodicity' do
  select 'PCV1', from: 'Resource'

  now = Time.now
  @start_weekly_time = (now + 1.hour)
  fill_in 'booking_start_date', with: @start_weekly_time.strftime("%d-%m-%Y %H:%M")
  fill_in 'booking_end_date', with: (now + 3.hours).strftime("%d-%m-%Y %H:%M")
  select 'Weekly', from: 'Repeat event'
  fill_in 'booking_until_date', with: (now + 3.weeks).strftime("%d-%m-%Y %H:%M")
  fill_in 'Comment', with: 'I have to create this weekly booking for my practices.'

  click_button 'Create booking'
end

step 'I can see that the booking with weekly periodicity has been created' do
  within '.bookings-list' do
    expect(page).to have_content('Virtual PC')
    expect(page).to have_content(@start_weekly_time.strftime("%B %d, %Y %H:%M"))
    expect(page).to have_content((@start_weekly_time + 1.week).strftime("%B %d, %Y %H:%M"))
    expect(page).to have_content((@start_weekly_time + 2.weeks).strftime("%B %d, %Y %H:%M"))
    expect(page).to have_content((@start_weekly_time + 3.weeks).strftime("%B %d, %Y %H:%M"))
  end
end

step 'I can see that the booking with periodicity does not exists' do
  within '.bookings-list' do
    expect(page).to_not have_content('Virtual PC')
    expect(page).to_not have_content(@start_weekly_time.strftime("%B %d, %Y %H:%M"))
    expect(page).to_not have_content((@start_weekly_time + 1.week).strftime("%B %d, %Y %H:%M"))
    expect(page).to_not have_content((@start_weekly_time + 2.weeks).strftime("%B %d, %Y %H:%M"))
    expect(page).to_not have_content((@start_weekly_time + 3.weeks).strftime("%B %d, %Y %H:%M"))
  end
end

step 'I can book an available resource with monthly periodicity' do
  select 'PCV1', from: 'Resource'

  now = Time.now
  @start_monthly_time = (now + 1.hour)
  fill_in 'booking_start_date', with: @start_monthly_time.strftime("%d-%m-%Y %H:%M")
  fill_in 'booking_end_date', with: (now + 3.hours).strftime("%d-%m-%Y %H:%M")
  select 'Monthly', from: 'Repeat event'
  fill_in 'booking_until_date', with: (now + 3.months).strftime("%d-%m-%Y %H:%M")
  fill_in 'Comment', with: 'I have to create this monthly booking for my practices.'

  click_button 'Create booking'
end

step 'I can see that the booking with monthly periodicity has been created' do
  expect(page).to have_content('Virtual PC')
  expect(page).to have_content(@start_monthly_time.strftime("%B %d, %Y %H:%M"))
  expect(page).to have_content((@start_monthly_time + 1.month).strftime("%B %d, %Y %H:%M"))
  expect(page).to have_content((@start_monthly_time + 2.months).strftime("%B %d, %Y %H:%M"))
  expect(page).to have_content((@start_monthly_time + 3.months).strftime("%B %d, %Y %H:%M"))
end
