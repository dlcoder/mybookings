require 'rails_helper'

step 'login a user' do
  visit '/users/sign_in'

  fill_in 'Email', with: @user.email
  fill_in 'Password', with: '12345678'

  click_button 'Sign in'
end

step 'a signed in user' do
  @user = users(:user)
  step 'login a user'
end

step 'a signed in administrator' do
  @user = users(:admin)
  step 'login a user'
end

step 'a signed in manager' do
  @user = users(:manager)
  step 'login a user'
end

step 'an existing booking' do
  step 'I go to the bookings page'
  step 'I go to the new booking page'
  step 'I can see the available resource types'
  step 'I can book an available resource'
  step 'the manager should receive an email to notify the creation'
end
