module Mybookings
  class Backend::BaseController < ApplicationController
    include Pundit

    before_action :authenticate_user!
    before_action :load_current_user

    layout 'layouts/mybookings/backend'

    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    private

    def load_current_user
      @current_user = current_user
    end

    def user_not_authorized
      redirect_to (request.referrer || root_path), alert: t('not_authorized')
    end
  end
end
