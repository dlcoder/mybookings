class ApplicationController < ActionController::Base
  # TODO: That makes login with SAML crashes
  # protect_from_forgery with: :exception

  def index
    return redirect_to bookings_path if user_signed_in?
    return render 'homepage'
  end

  private

  def after_sign_in_path_for resource
    bookings_path
  end

  def after_sign_out_path_for resource
    root_path
  end
end
