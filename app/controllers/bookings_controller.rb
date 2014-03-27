class BookingsController < BaseController

  def index
    @current_user = current_user
  end

end
