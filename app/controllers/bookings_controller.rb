class BookingsController < BaseController

  def index; end

  def new
    @booking = Booking.new
  end

end
