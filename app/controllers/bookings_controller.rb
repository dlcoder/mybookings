class BookingsController < BaseController

  def index; end

  def new
    load_resources
    @booking = Booking.new
  end

  def create
    @booking = Booking.create(booking_params)
    return redirect_to bookings_path if @booking.valid?
    load_resources
    render 'new'
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :resource_id)
  end

  def load_resources
    @resources = Resource.all
  end

end
