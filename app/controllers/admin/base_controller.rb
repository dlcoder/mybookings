class Admin::BaseController < ApplicationController
  before_action :authenticate_user!
  before_action :is_an_admin
  before_action :load_current_user

  layout 'admin'

  private

  def load_current_user
    @current_user = current_user
  end

  def is_an_admin
    not_authorized unless current_user.has_role? :admin
  end

  def not_authorized
    redirect_to (request.referrer || root_path), alert: t('not_authorized')
  end
end
