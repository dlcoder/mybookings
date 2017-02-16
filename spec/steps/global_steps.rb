require 'rails_helper'

step 'a signed in user' do
  @user = mybookings_users(:user)
  step 'login a user'
end

step 'login a user' do
  visit '/users/sign_in'

  fill_in 'Email', with: @user.email
  fill_in 'Password', with: '12345678'

  click_button 'Sign in'
end

step 'a signed in administrator' do
  @user = mybookings_users(:admin)
  step 'login a user'
end

step 'a signed in manager' do
  @user = mybookings_users(:manager)
  step 'login a user'
end

step 'an existing booking' do
  step 'I go to the bookings page'
  step 'I can start to create a booking'
  step 'I can book an available resource'
  step 'the manager should receive an email to notify the creation'
end
