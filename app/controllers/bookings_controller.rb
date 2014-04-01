class BookingsController < BaseController

  def index; end

  def new
    @resources = Resource.all
    @booking = Booking.new
  end

  def create
    return redirect_to bookings_path if CreatesBooking.from_booking_params(booking_params)
    render 'new'
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :resource_id)
  end

end
