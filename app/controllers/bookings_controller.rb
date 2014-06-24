class BookingsController < BaseController

  before_action :load_booking, only: [:destroy, :edit_feedback, :set_feedback]

  def index
    load_current_user_bookings
  end

  def new
    load_available_resources_by_type_name_and_name
    @booking = Booking.new
  end

  def create
    @booking = Booking.create_for_user(current_user, booking_params)
    return redirect_to bookings_path if @booking.valid?
    load_available_resources_by_type_name_and_name
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

  def load_available_resources_by_type_name_and_name
    @resources = Resource.avalaible_by_type_name_and_name
  end

  def load_booking
    booking_id = params[:id] || params[:booking_id]

    @booking = Booking.find(booking_id)
    authorize @booking
  end

  def load_current_user_bookings
    @bookings = policy_scope(Booking).by_start_date
  end

end
