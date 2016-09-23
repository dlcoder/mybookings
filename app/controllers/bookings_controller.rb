class BookingsController < BaseController
  before_action :load_booking, only: [:destroy, :edit_feedback, :set_feedback]

  def index
    load_current_user_bookings
  end

  def new
    load_available_resources_by_type_name_and_name
    @booking = Booking.new
    @booking.events.build
  end

  def create
    @booking = Booking.new_for_user(current_user, booking_params)

    if @booking.valid?
      ResourceTypesExtensionsWrapper.call(:after_booking_creation, @booking)
      @booking.save!
      NotificationsMailer.notify_new_booking(@booking).deliver_now!
      return redirect_to bookings_path
    else
      load_available_resources_by_type_name_and_name
      render 'new'
    end
  end

  def destroy
    if @booking.pending?
      NotificationsMailer.notify_delete_booking(@booking).deliver_now!
      @booking.destroy
    end
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
    params.require(:booking).permit!
  end

  def load_available_resources_by_type_name_and_name
    @resources = Resource.avalaible_by_type_name_and_name
  end

  def load_booking
    booking_id = params[:id] || params[:booking_id]

    @booking = BookingDecorator.find(booking_id)
    authorize @booking
  end

  def load_current_user_bookings
    @bookings = policy_scope(Booking).by_start_date.decorate
  end
end
