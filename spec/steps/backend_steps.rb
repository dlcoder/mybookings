require 'spec_helper'

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
  fill_in 'Resource name', with: 'PCV5'

  click_button 'Create resource'
end

step 'I can see that the resource has been added' do
  expect(page).to have_content('PCV5')
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
  fill_in 'Resource type name', with: 'Virtual'
end

step 'I can update the resource type' do
  click_button 'Update resource type'
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
  select 'manager', from: 'Role'
end

step 'I can assign the list of resource types that the user can manage' do
  check 'Adobe Connect Meeting Rooms'
end

step 'I can save the user' do
  click_button 'Save user'
end

step 'I can see a bookings of a resource and all the info of them' do
  find('tr', text: 'ACMR2').click_link 'Show bookings'

  expect(page).to have_content('user@mybookings.com')
  expect(page).to have_content('January 02, 2000 13:00')
  expect(page).to have_content('January 02, 2000 14:00')
  expect(page).to have_content('The resource have a lot of problems.')
end
