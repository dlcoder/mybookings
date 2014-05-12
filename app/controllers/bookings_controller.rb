class BookingsController < BaseController
  before_action :load_booking, only: [:destroy, :edit_feedback, :set_feedback]

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
    @booking.destroy
    redirect_to bookings_path
  end

  def edit_feedback; end

  def set_feedback
    @booking.feedback = params[:booking][:feedback]
    @booking.save!

    redirect_to bookings_path, notice: I18n.t('bookings.index.feedback_received')
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :resource_id)
  end

  def load_resources
    @resources = Resource.all
  end

  def load_booking
    booking_id = params[:id] || params[:booking_id]

    @booking = Booking.find(booking_id)
  end

  def load_current_user_bookings
    @bookings = Booking.for_user current_user
  end
end
