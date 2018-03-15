require 'rails_helper'

step 'I go to the manage page' do
  within '.navbar' do
    click_link 'Manage'
  end
end

step 'I click on Resources menu item' do
  within '#backend-menu' do
    click_link 'Resources'
  end
end

step 'I can view a list of resources' do
  expect(page).to have_content 'PCV1'
end

step 'I can disable a resource' do
  find('tr', text: 'PCV1').click_link 'Disable'
end

step 'I can enable a resource' do
  first(:link, 'Enable').click
end

step 'I can add a new resource' do
  click_link 'New resource'

  select 'Adobe Connect Meeting Room', from: 'Resource type'
  fill_in 'Resource name', with: 'ACMR5'

  click_button 'Create resource'
end

step 'I can see that the resource has been added' do
  expect(page).to have_content('ACMR5')
end

step 'I can see the events of a resource' do
  event = mybookings_events(:event2)

  find('tr', text: 'ACMR2').click_link 'Show bookings'

  within '#bookings-calendar' do
    click_button 'list'
    expect(page).to have_content('Adobe Connect Meeting Rooms - ACMR2')
    expect(page).to have_content("#{event.start_date.strftime('%k:%M')} - #{event.end_date.strftime('%k:%M')}")
  end
end

step 'I can visit the booking details page of an event' do
  find('.fc-list-item:last-child').click_link 'Adobe Connect Meeting Rooms - ACMR2'
end

step 'I can see that I can cancel or reallocate an event' do
  event = mybookings_events(:pending_event)
  within "#event-#{event.id}" do
    click_link 'Cancel or reallocate'
  end
end

step 'I cannot reallocate the event to a disabled resource' do
  expect(page).to_not have_content('Adobe Connect Meeting Rooms: Disabled resource')
end

step 'I cannot reallocate the event to a resource with an overlapped booking' do
  expect(page).to_not have_content('Adobe Connect Meeting Rooms: ACMR3')
end

step 'I can reallocate an event' do
  select 'Adobe Connect Meeting Rooms: ACMR5', from: 'Resource'
  click_button 'Reallocate to another resource'

  expect(page).to have_content('The booking has been reasigned.')
end

step 'I can cancel an event' do
  find('tr', text: 'ACMR5').click_link 'Show bookings'
  click_button 'list'
  click_link 'Adobe Connect Meeting Rooms - ACMR5'
  step 'I can see that I can cancel or reallocate an event'
  fill_in 'Reason', with: 'There is an issue with this booking'
  click_button 'Cancel booking'

  expect(page).to have_content('The booking has been canceled.')
end

step 'the booking owner should receive an email with the cancellation reason' do
  user = mybookings_users(:user)

  expect(unread_emails_for(user.email).size).to eq(1)

  open_last_email_for(user.email)

  expect(current_email.body).to include('There is an issue with this booking')
end

step 'I can cancel a resource' do
  step 'I click on Resources menu item'
  find('tr', text: 'acmr_cancel').click_link('Delete')
end

step 'I can see that the resource has been canceled' do
  expect(page).to_not have_content('acmr_cancel')
end

step 'I can see that bookings with events associated with the cancelled resource has not been cancelled because they have events associated with another resource' do
  event = mybookings_events(:cancel_resource_event1)

  find('tr', text: 'ACMR3').click_link('Show bookings')
  click_button 'list'
  find('.fc-list-item:last-child').click_link 'Adobe Connect Meeting Rooms - ACMR3'

  within "#event-#{event.id}" do
    expect(page).to have_content('Pending')
  end
end

step 'I click on Resource types menu item' do
  within '#backend-menu' do
    click_link 'Resource types'
  end
end

step 'I can view a list of resource types' do
  expect(page).to have_content 'Adobe Connect Meeting Rooms'
end

step 'I can add a new resource type' do
  click_link 'New resource type'

  fill_in 'Resource type name', with: 'Virtual PC'
  select 'DefaultExtension', from: 'Resource type extension'

  click_button 'Create resource type'
end

step 'I can edit a resource type' do
  find('tr', text: 'Adobe Connect Meeting Rooms').click_link ('Edit')
end

step 'I can change the name of the resource type' do
  fill_in 'Resource type name', with: 'Adobe Rooms'
end

step 'I can update the resource type' do
  click_button 'Update resource type'
end

step 'I can cancel the resource type' do
  find('tr', text: 'Adobe Rooms').click_link('Delete')
end

step 'I can see that the resource type has been cancelled' do
  expect(page).to_not have_content('Adobe Rooms')
end

step 'I can see that the resources associated with the resource type has been canceled' do
  step 'I click on Resources menu item'
  expect(page).to_not have_content('ACMR1')
  expect(page).to_not have_content('ACMR2')
  expect(page).to_not have_content('ACMR3')
  expect(page).to_not have_content('acmr_cancel')
  expect(page).to_not have_content('Disabled resource')
  expect(page).to_not have_content('ACMR5')
end

step 'I click on Users menu item' do
  within '#backend-menu' do
    click_link 'Users'
  end
end

step 'I can view a list of users registered on MyBookings' do
  expect(page).to have_content('user@mybookings.com')
  expect(page).to have_content('admin@mybookings.com')
end

step 'I can edit an user' do
  click_link 'user@mybookings.com'
end

step 'I can set the user as resource manager' do
  check 'manager'
end

step 'I can assign the list of resource types that the user can manage' do
  check 'Adobe Connect Meeting Rooms'
end

step 'I can save the user' do
  click_button 'Save user'
end

step 'I can create a new user' do
  click_link 'New user'

  fill_in 'Email', with: 'example@example.com'
  check 'manager'
  check 'Virtual PC'

  click_button 'Create user'
end

step 'I can see that the user has been created' do
  within '#table-users > tbody > tr:last-child' do
    expect(page).to have_content('example@example.com')
    expect(page).to have_content('manager')
  end
end

step 'I can search for an user' do
  fill_in 'search', with: 'use'
  click_button 'Search'
end

step 'I can see the results of the search' do
  expect(page).to have_content('user@mybookings.com')
end

step 'I click on Statistics menu item' do
  within '#backend-menu' do
    click_link 'Statistics'
  end
end

step 'I can view the available statistics' do
  expect(page).to have_content('Use by resource')
  expect(page).to have_content('Use by hour')
end

step 'I can view the resource statistics' do
  click_link 'Use by resource'
end

step 'I can see the statistics for all available resources' do
  expect(page).to have_select('Resource type', selected: 'Adobe Connect Meeting Rooms')
  expect(page).to have_selector('text', :class => 'ct-bar-label', :text => '4')
  select 'Virtual PC', from: 'Resource type'
  expect(page).to have_select('Resource type', selected: 'Virtual PC')
  expect(page).to_not have_selector('text', :class => 'ct-bar-label')
  select 'Resource type for all users', from: 'Resource type'
  expect(page).to have_select('Resource type', selected: 'Resource type for all users')
end

step 'I can see the statistics only for the resources I can manage' do
  expect(page).to have_select('Resource type', selected: 'Adobe Connect Meeting Rooms')
  expect(page).to have_selector('text', :class => 'ct-bar-label')
  select 'Virtual PC', from: 'Resource type'
  expect(page).to have_select('Resource type', selected: 'Virtual PC')
  expect(page).to_not have_selector('text', :class => 'ct-bar-label')
  expect(page).to_not have_select('Resource type', options: ['Resource type for all users'])
end
