require 'spec_helper'

step 'I visit the homepage' do
  visit root_path
end

step 'I go to the sign in page' do
  click_link 'Sign in'
end

step 'I go to the sign up page' do
  click_link 'Sign up'
end

step 'I can sign up' do
  fill_in 'Email', with: 'new_user@mybookings.com'
  fill_in 'Password', with: '12345678'
  fill_in 'Password confirmation', with: '12345678'
  click_button 'Sign up'
end

step 'I can see that I have signed up' do
  expect(page).to have_content('Welcome! You have signed up successfully.')
  expect(page).to have_content('You are logged in as new_user@mybookings.com')
end

step 'I can see my bookings page' do
  expect(page).to have_content('My bookings')
end

step 'a registered user' do
  @user = users(:user)
end

step 'I can sign in' do
  fill_in 'Email', with: @user.email
  fill_in 'Password', with: '12345678'
  click_button 'Sign in'
end

step 'I can see that I have signed in' do
  expect(page).to have_content('Signed in successfully.')
  expect(page).to have_content("You are logged in as #{ @user.email }")
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