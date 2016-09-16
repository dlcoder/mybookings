class Backend::BookingsController < Backend::BaseController
  include Backend::Administerable
  include Backend::Manageable
  include Backend::Authorizable

  before_action :load_resource, only: [:index, :delete_confirmation, :destroy]
  before_action :load_booking, only: [:delete_confirmation, :destroy]

  def index
    @bookings = @resource.bookings.decorate
  end

  def delete_confirmation
    @booking_form = DeleteBookingForm.new
  end

  def destroy
    @booking_form = DeleteBookingForm.new(params[:delete_booking_form])
    if @booking_form.valid?
      logger.info "The booking #{@booking.name} of the resource #{@resource.name} has been deleted. The reason is reason: #{@booking_form.reason}"
      @booking.destroy!
      redirect_to backend_resource_bookings_path, notice: I18n.t('bookings.destroy.cancel_notice')
    else
      render 'delete_confirmation'
    end
  end

  private

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
