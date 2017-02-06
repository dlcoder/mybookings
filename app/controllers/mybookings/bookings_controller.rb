module Mybookings
  class BookingsController < BaseController
    before_action :load_booking, only: [:destroy]

    def index
      load_current_user_bookings
    end

    def new
      if params[:resource_type_id].nil?
        @resource_types = ResourceType.all
      else
        load_resource_type
        load_available_resources_by_resource_type @resource_type
        @booking = booking_class.new(resource_type: @resource_type)
      end
    end

    def create
      @booking = booking_class.new_for_user(current_user, booking_params)

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
      params.require(:booking).permit!
    end

    def booking_class
      booking_class = params[:booking_class]

      return default_booking_class_constant if booking_class.nil?
      return default_booking_class_constant unless booking_class.ends_with?('Booking')

      booking_class_constant = "#{booking_class}".constantize

      return default_booking_class_constant unless defined?(booking_class_constant)

      return booking_class_constant
    end

    def default_booking_class_constant
      Mybookings::Booking
    end

    def load_available_resources_by_resource_type resource_type
      @resources = Resource.available_by_resource_type resource_type
    end

    def load_booking
      @booking = BookingDecorator.find(params[:id])
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
