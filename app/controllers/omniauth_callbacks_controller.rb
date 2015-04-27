class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def feide
    @user = User.find_saml_user_or_create(request.env['omniauth.auth'])

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: 'feide') if is_navigational_format?
    else
      session['devise.saml_data'] = request.env['omniauth.auth']
      redirect_to new_user_registration_url
    end
  end
end
