module Mybookings
  class EventsController < BaseController
    before_action :load_event , only: [:destroy, :edit_feedback, :set_feedback]

    def destroy
      booking = @event.booking
      @event.destroy! if @event.pending?
      booking.destroy unless booking.has_events?
      redirect_to bookings_path
    end

    def edit_feedback; end

    def set_feedback
      @event.feedback = params[:event][:feedback]
      @event.save!

      redirect_to bookings_path, notice: I18n.t('events.index.feedback_received')
    end

    private

    def load_event
      event_id = params[:id] || params[:event_id]

      @event = Event.find(event_id)
    end
  end
end
