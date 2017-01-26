module Mybookings
  class ResourcesController < BaseController

    before_action :load_resource, only: [:events]
    before_action :load_start_end, only: [:events]

    def events
      @events = Event.active_by_resource_between @resource, @start_date, @end_date
    end

    private

    def load_resource
      @resource = Resource.find(params[:resource_id])
    end

    def load_start_end
      @start_date = params[:start].to_datetime
      @end_date = params[:end].to_datetime
    end

  end
end
