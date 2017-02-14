module Mybookings
  class BookingsController < BaseController
    before_action :load_booking, only: [:edit, :update, :destroy]
    before_action :load_resource_type, only: [:new, :create]

    def index
      @resource_types = policy_scope(ResourceType.all)
      load_current_user_bookings
    end

    def new
      load_available_resources_by_resource_type @resource_type
      @booking = booking_type.new(resource_type: @resource_type)
    end

    def edit; end

    def create
      @booking = booking_type.new_for_user(current_user, booking_params)

      if @booking.invalid?
        @resource_type = @booking.resource_type
        load_available_resources_by_resource_type @resource_type
        return render 'new'
      end

      @booking.save!
      @booking.confirm!

      NotificationsMailer.notify_new_booking(@booking).deliver_now!

      redirect_to bookings_path
    end

    def update
      unless @booking.has_pending_events?
        flash.now[:alert] = 'Can\'t update a booking without pending events.'
        return render 'edit'
      end

      if @booking.update_attributes(booking_params_for_update)
        @booking.update_attribute(:prepared, false)
        return redirect_to bookings_path
      end

      return render 'edit'
    end

    def destroy
      # Only we delete the pending events associated to the booking.
      # If a booking has events with other statuses we don't delete the booking.
      if @booking.has_pending_events?
        @booking.delete_pending_events
      end

      unless @booking.has_events?
        @booking.cancel!
        @booking.destroy!
        NotificationsMailer.notify_delete_booking(@booking).deliver_now!
      end

      redirect_to bookings_path
    end

    private

    def booking_params
      params.require(booking_type.model_name.param_key).permit!
    end

    def booking_params_for_update
      {}
    end

    def booking_type
      Booking
    end

    def load_available_resources_by_resource_type resource_type
      @resources = Resource.available_by_resource_type resource_type
    end

    def load_booking
      @booking = BookingDecorator.find(params[:id] || params[:booking_id])
      authorize @booking
    end

    def load_resource_type
      @resource_type = ResourceType.find(params[:resource_type_id])
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
end
