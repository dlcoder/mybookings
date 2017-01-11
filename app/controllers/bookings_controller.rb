class BookingsController < BaseController
  before_action :load_booking, only: [:destroy]

  def index
    load_current_user_bookings
  end

  def new_booking_resource_type_step
    @resource_types = ResourceType.all
  end

  def new_booking_events_step
    resource_type = ResourceType.find(params[:booking_id])
    load_available_resources_by_resource_type resource_type
    @booking = Booking.new(resource_type: resource_type)
    @booking.events.build
  end

  def create
    @booking = Booking.new_for_user(current_user, booking_params)

    if @booking.valid?
      # If it's a valid booking we have to fire, for all events in a booking,
      # the creation event in the resource type associated.
      @booking.events.each do |event|
        ResourceTypesExtensionsWrapper.call(:after_booking_creation, event)
      end

      @booking.save!

      NotificationsMailer.notify_new_booking(@booking).deliver_now!

      return redirect_to bookings_path
    else
      load_available_resources_by_resource_type @booking.resource_type

      render 'new_booking_events_step'
    end
  end

  def destroy
    if @booking.has_pending_events?
      NotificationsMailer.notify_delete_booking(@booking).deliver_now!
      # Only we delete the pending events associated to the booking.
      # If a booking has events with other statuses we don't delete the booking for archival purposes.
      @booking.delete_pending_events
      @booking.destroy unless @booking.has_events?
    end

    redirect_to bookings_path
  end

  private

  def booking_params
    params.require(:booking).permit!
  end

  def load_available_resources_by_resource_type resource_type
    @resources = Resource.available_by_resource_type resource_type
  end

  def load_booking
    booking_id = params[:id] || params[:booking_id]

    @booking = BookingDecorator.find(booking_id)
    authorize @booking
  end

  def load_current_user_bookings
    # This map is necessary to decorate bookings in the array returned by the model method.
    # The model method not return a collection.
    @bookings = policy_scope(Booking).by_start_date_group_by_resource_type.map { |resource_type, bookings| [
      resource_type,
      BookingDecorator.decorate_collection(bookings)
    ] }
  end
end
