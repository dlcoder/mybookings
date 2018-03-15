require 'rails_helper'

step 'I go to the bookings page' do
  visit '/bookings'
end

step 'I can book resources without role restrictions' do
  expect(page).to have_content('Resource type for all users')
  expect(page).not_to have_content('Virtual PC')
end

step 'I can start to create a booking' do
  click_button 'Book a resource'
  within '.btn-group' do
    click_link 'Virtual PC'
  end
end

step 'I cannot see the until date field when is selected the no repeat option' do
  expect(page).to have_select('Repeat event', selected: 'No repeat')
  expect(page).to have_css('.js-dynamic-form-element-to-hide', visible: false)
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

  @now = Time.now
  fill_in 'booking_start_date', with: (@now + 1.hour).strftime("%d-%m-%Y %H:%M")
  fill_in 'booking_end_date', with: (@now + 3.hours).strftime("%d-%m-%Y %H:%M")
  fill_in 'Comment', with: 'I need that resource just in time.'

  click_button 'Create booking'
end

step 'I can see that the booking has been created' do
  within '#bookings-calendar' do
    expect(page).to have_content('Virtual PC - PCV1')
    expect(page).to have_content("#{(@now + 1.hour).strftime('%k:%M')} - #{(@now + 3.hours).strftime('%k:%M')}")
  end
end

step 'the manager should receive an email to notify the creation' do
  user = mybookings_users(:manager)
  resource_type = mybookings_resource_types(:pcv)

  expect(unread_emails_for(resource_type.notifications_emails[0]).size).to eq(1)

  open_last_email_for(resource_type.notifications_emails[0])

  expect(current_email.subject).to include('New booking of')
end

step 'the user should receive an email to notify the creation' do
  skip

  user = mybookings_users(:user)

  expect(unread_emails_for(user.email).size).to eq(1)

  open_last_email_for(user.email)

  expect(current_email.subject).to include('New booking of')
end

step 'I visit the booking details for a old expired event' do
  within '#bookings-calendar' do
    find('.fc-prev-button').click
    find('.fc-prev-button').click

    click_link 'Adobe Connect Meeting Rooms - ACMR3'
  end
end

step 'I visit the booking details for a recently expired event' do
  within '#bookings-calendar' do
    click_link 'Adobe Connect Meeting Rooms - ACMR1'
  end
end

step 'I cannot submit feedback' do
  sleep 1
  expect(page).to_not have_content('Send comments')
end

step 'I can submit feedback' do
  click_link 'Send comments'
  fill_in 'Feedback', with: 'The system was very slow.'
  click_button 'Send feedback'
end

step 'I can see that the feedback has been submitted' do
  expect(page).to have_content('Thanks. We have received your feedback.')
end

step 'I can see the weekly booking details' do
  within '#bookings-calendar' do
    click_link('Virtual PC - PCV1')
  end

  expect(page).to have_content('Data for booking #')
  expect(page).to have_selector('.booking-events .panel', count: 4)

  click_link 'Show all events for the booking'
  expect(page).to have_selector('.booking-events .panel', count: 5)
end

step 'I can cancel the booking' do
  click_link 'Cancel booking'
end

step 'I can see that the booking does not exists' do
  within '.bookings-list' do
    expect(page).to_not have_content('Virtual PC')
  end
end

step 'the manager should receive an email to notify the cancelation' do
  user = mybookings_users(:manager)
  resource_type = mybookings_resource_types(:pcv)

  expect(unread_emails_for(resource_type.notifications_emails[0]).size).to eq(1)

  open_last_email_for(resource_type.notifications_emails[0])

  expect(current_email.subject).to include("Booking of #{resource_type.name} canceled by the user")
end

step 'I can book an available resource with weekly periodicity' do
  select 'PCV1', from: 'Resource'

  @now = Time.now

  fill_in 'booking_start_date', with: (@now + 1.hour).strftime("%d-%m-%Y %H:%M")
  fill_in 'booking_end_date', with: (@now + 3.hours).strftime("%d-%m-%Y %H:%M")
  select 'Weekly', from: 'Repeat event'
  fill_in 'booking_until_date', with: (@now + 4.weeks + 1.hour).strftime("%d-%m-%Y %H:%M")

  fill_in 'Comment', with: 'I have to create this weekly booking for my practices.'

  click_button 'Create booking'
end

step 'I can see that the booking with weekly periodicity has been created' do
  within '#bookings-calendar' do
    i = 0
    hours_string = "#{(@now + 1.hour).strftime('%k:%M')} - #{(@now + 3.hours).strftime('%k:%M')}"

    loop do
      within '.fc-toolbar .fc-center' do
        first_day_of_week = (@now + i.weeks).beginning_of_week(start_day = :sunday).strftime("%e")
        expect(page).to have_content("#{first_day_of_week} ")

        last_day_of_week = (@now + i.weeks).end_of_week(start_day = :sunday).strftime("%e")
        expect(page).to have_content(" #{last_day_of_week} ")
      end

      expect(page).to have_content('Virtual PC - PCV1')
      expect(page).to have_content(hours_string)

      find('.fc-next-button').click
      i += 1

      break if i.eql?(5)
    end

    expect(page).to_not have_content(hours_string)
  end
end

step 'I can see that the booking with periodicity does not exists' do
  within '#bookings-calendar' do
    expect(page).to_not have_content('Virtual PC - PCV1')
  end
end

step 'I can book an available resource with monthly periodicity' do
  select 'PCV1', from: 'Resource'

  @now = Time.now

  fill_in 'booking_start_date', with: (@now + 1.hour).strftime("%d-%m-%Y %H:%M")
  fill_in 'booking_end_date', with: (@now + 3.hours).strftime("%d-%m-%Y %H:%M")
  select 'Monthly', from: 'Repeat event'
  fill_in 'booking_until_date', with: (@now + 5.months + 1.hour).strftime("%d-%m-%Y %H:%M")

  fill_in 'Comment', with: 'I have to create this monthly booking for my practices.'

  click_button 'Create booking'
end

step 'I can see that the booking with monthly periodicity has been created' do
  within '#bookings-calendar' do
    find('.fc-month-button').click

    i = 0

    loop do
      within '.fc-toolbar .fc-center' do
        current_month = (@now + i.months).strftime('%B')
        current_year = (@now + i.months).strftime('%Y')

        expect(page).to have_content("#{current_month} #{current_year}")
      end

      expect(page).to have_content('Virtual PC - PCV1')
      expect(page).to have_content("#{(@now + 1.hour).strftime('%k:%M')}")

      find('.fc-next-button').click
      i += 1

      break if i.eql?(5)
    end

    expect(page).to_not have_content('Virtual PC - PCV1')
  end
end
