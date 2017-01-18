require 'rails_helper'

step 'I visit the homepage' do
  # TODO: workaround to solve the following error running tests:
  #   undefined local variable or method `root_path'
  #
  # visit root_path
  visit '/'
end

step 'I go to the sign up page' do
  click_link 'Sign up for a new account'
end

step 'I can sign up' do
  fill_in 'Email', with: 'new_user@mybookings.com'
  fill_in 'Password', with: '12345678'
  fill_in 'Password confirmation', with: '12345678'
  click_button 'Sign up'
end

step 'I can see that I have signed up' do
  expect(page).to have_content('Welcome! You have signed up successfully.')
  expect(page).to have_content('new_user@mybookings.com')
end

step 'I can see my bookings page' do
  expect(page).to have_content('My bookings')
end

step 'a registered user' do
  @user = mybookings_users(:user)
end

step 'I can sign in' do
  fill_in 'Email', with: @user.email
  fill_in 'Password', with: '12345678'
  click_button 'Sign in'
end

step 'I can see that I have signed in' do
  expect(page).to have_content('Signed in successfully.')
  expect(page).to have_content("#{ @user.email }")
end

step 'I go to the sign in with saml page' do
  click_link 'Sign in with saml'
end

step 'I can see that I have signed in with saml' do
  expect(page).to have_content('Successfully authenticated from saml account.')
end

step 'I go to sign out' do
  click_link 'Sign out'
end

step 'I can see that I have signed out' do
  expect(page).to have_content('Signed out successfully.')
end

step 'I can see the homepage' do
  expect(page).to have_selector('body.homepage')
end
