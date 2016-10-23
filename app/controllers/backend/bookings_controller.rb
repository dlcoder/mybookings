class Backend::BookingsController < Backend::BaseController
  include Backend::Administerable
  include Backend::Manageable
  include Backend::Authorizable

  before_action :load_resource, only: [:index, :delete_confirmation, :destroy]
  before_action :load_booking, only: [:delete_confirmation, :destroy, :update]

  def index
    @bookings = @resource.bookings.decorate
  end

  def delete_confirmation
    @booking_form = DeleteBookingForm.new
    @resources = @booking.alternative_resources
  end

  def destroy
    @booking_form = DeleteBookingForm.new(params[:delete_booking_form])

    unless @booking_form.valid?
      @resources = @booking.alternative_resources
      return render 'delete_confirmation'
    end

    logger.info "The booking #{@booking.id} of the resource #{@resource.name} has been deleted. The reason is: #{@booking_form.reason}"
    @booking.destroy!
    BookingsMailer.cancel_booking(@booking, @booking_form.reason).deliver!
    redirect_to backend_resource_bookings_path, notice: I18n.t('backend.bookings.destroy.cancel_notice')
  end

  def update
    return render 'delete_confirmation' unless @booking.valid?

    @booking.update(booking_params)
    redirect_to backend_resources_path, notice: I18n.t('backend.bookings.update.reallocated_notice')
  end

  private

  def booking_params
    params.require(:booking).permit!
  end

  def load_resource
    resource_id = params[:resource_id]

    @resource = Resource.find(resource_id)
    authorize @resource
  end

  def load_booking
    booking_id = params[:booking_id].nil? ? params[:id] : params[:booking_id]

    @booking = Booking.find(booking_id);
    authorize @booking
  end
end
