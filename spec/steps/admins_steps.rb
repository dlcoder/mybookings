require 'spec_helper'

step 'I go to the administer page' do
  within '.navbar' do
    click_link 'Administer'
  end
end

step 'I click on Resources menu item' do
  within '#admin-menu' do
    click_link 'Resources'
  end
end

step 'I can view a list of resources' do
  expect(page).to have_content 'PCV1'
end

step 'I can disable a resource' do
  within 'table#resources tbody tr:first-child' do
    click_link 'Disable'
  end
end

step 'I can enable a resource' do
  first(:link, 'Enable').click
end

step 'I can add a new resource' do
  click_link 'New resource'

  fill_in 'Resource name', with: 'PCV5'

  click_button 'Create resource'
end
