require 'spec_helper'

step 'a signed in user' do
  @user = users(:user)

  visit '/users/sign_in'

  fill_in 'Email', with: @user.email
  fill_in 'Password', with: '12345678'

  click_button 'Sign in'
end
