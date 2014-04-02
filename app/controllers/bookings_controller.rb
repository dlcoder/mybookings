class BookingsController < BaseController

  def index; end

  def new
    load_resources
    @booking_form = BookingForm.new
  end

  def create
    @booking_form = BookingForm.new booking_form_params
    if @booking_form.valid? then
      CreatesBooking.from_booking_form @booking_form
      return redirect_to bookings_path
    else
      load_resources
      render 'new'
    end
  end

  private

  def booking_form_params
    params.require(:booking_form).permit(:start_date, :end_date, :resource_id)
  end

  def load_resources
    @resources = Resource.all
  end

end
