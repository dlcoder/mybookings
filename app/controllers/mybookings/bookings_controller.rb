module Mybookings
  class BookingsController < BaseController
    before_action :load_booking, only: [:show, :update, :destroy]
    before_action :load_resource_type, only: [:new, :create]

    def index
      @resource_types = policy_scope(ResourceType.all)
      load_current_user_bookings
    end

    def new
      load_available_resources_by_resource_type @resource_type
      @booking = booking_type.new(resource_type: @resource_type)
    end

    def show; end

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
        flash.now[:alert] = I18n.t('mybookings.bookings.update.pending_events_required')
        return render 'show'
      end

      params = booking_params_for_update.merge({ prepared: false })
      if @booking.update_attributes(params)
        return redirect_to bookings_path
      end

      return render 'show'
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

    def booking_decorator_type
      BookingDecorator
    end

    def load_available_resources_by_resource_type resource_type
      @resources = Resource.available_by_resource_type resource_type
    end

    def load_booking
      @booking = booking_decorator_type.find(params[:id] || params[:booking_id]).decorate
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
        booking_decorator_type.decorate_collection(bookings)
      ] }
    end
  end
end
