module Mybookings
  class Backend::EventsController < Backend::BaseController
    include Backend::Administerable
    include Backend::Manageable
    include Backend::Authorizable

    before_action :load_resource, only: [:index, :delete_confirmation, :destroy, :update]
    before_action :load_event, only: [:delete_confirmation, :destroy, :update]

    def index
      @events = @resource.events
    end

    def delete_confirmation
      @delete_form = DeleteEventForm.new
      @resources = @event.alternative_resources
    end

    def destroy
      event_form = DeleteEventForm.new(params[:delete_event_form])

      unless event_form.valid?
        resources = @event.alternative_resources
        return render 'delete_confirmation'
      end

      booking = @event.booking

      @event.destroy!
      booking.destroy! unless booking.has_events?

      logger.info "The event #{@event.id} of the booking #{@event.booking.id} in the resource #{@resource.name} has been deleted. The reason is: #{event_form.reason}"

      redirect_to backend_resource_events_path, notice: I18n.t('mybookings.backend.events.destroy.cancel_notice')
    end

    def update
      return render 'delete_confirmation' unless @event.valid?

      @event.update(event_params)
      redirect_to backend_resources_path, notice: I18n.t('mybookings.backend.events.update.reallocated_notice')
    end

    private

    def event_params
      params.require(:event).permit(:resource_id)
    end

    def load_event
      event_id = params[:id] || params[:event_id]

      @event = Event.find(event_id)
      authorize @event
    end

    def load_resource
      resource_id = params[:resource_id] || params[:id]

      @resource = Resource.find(resource_id)
      authorize @resource, :manage_by_manager?
    end

  end
end
