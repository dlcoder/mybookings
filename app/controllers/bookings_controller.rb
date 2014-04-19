class BookingsController < BaseController

  def index
    load_current_user_bookings
  end

  def new
    load_resources
    @booking = Booking.new
  end

  def create
    @booking = Booking.create_for_user(current_user, booking_params)
    return redirect_to bookings_path if @booking.valid?
    load_resources
    render 'new'
  end

  def destroy
    booking = Booking.find(params[:id])
    booking.destroy
    redirect_to bookings_path
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :resource_id)
  end

  def load_resources
    @resources = Resource.all
  end

  def load_current_user_bookings
    @bookings = Booking.for_user current_user
  end

end
