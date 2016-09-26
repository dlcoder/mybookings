class EventsController < BaseController

  before_action :load_event , only: [:destroy]

  def destroy
    booking = @event.booking
    @event.destroy! if @event.pending?
    booking.destroy unless booking.has_events?
    redirect_to bookings_path
  end

  private
  def load_event
    event_id = params[:id]

    @event = Event.find(event_id)
  end
end
