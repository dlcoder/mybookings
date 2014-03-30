class ::BaseController < ApplicationController

  before_action :authenticate_user!
  before_action :load_current_user

  private

  def load_current_user
    @current_user = current_user
  end

end
