module Mybookings
  class EventsController < BaseController
    before_action :load_event, only: [:destroy, :edit_feedback, :set_feedback]
    before_action :load_booking, only: [:index]

    def index
      @events = EventDecorator.decorate_collection(@booking.events.recents)
    end

    def destroy
      booking = @event.booking

      if @event.pending?
        @event.cancel!
        @event.destroy!
      end

      unless booking.has_events?
        booking.cancel!
        booking.destroy!
      end

      redirect_to bookings_path
    end

    def edit_feedback; end

    def set_feedback
      @event.feedback = params[:event][:feedback]
      @event.save!

      redirect_to bookings_path, notice: I18n.t('mybookings.events.index.feedback_received')
    end

    private

    def load_event
      event_id = params[:event_id] || params[:id]

      @event = EventDecorator.find(event_id)
    end

    def load_booking
      booking_id = params[:booking_id] || params[:id]

      @booking = BookingDecorator.find(booking_id)
      authorize @booking
    end
  end
end
