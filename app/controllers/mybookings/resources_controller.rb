module Mybookings
  class ResourcesController < BaseController
    before_action :load_resource, only: [:events]
    before_action :load_start_end, only: [:events]

    def events
      @events = Event.by_resource(@resource)
                     .not_pending
                     .between(@start_date, @end_date)
    end

    private

    def load_resource
      @resource = Resource.find(params[:resource_id])
    end

    def load_start_end
      @start_date = Time.parse(params[:start])
      @end_date = Time.parse(params[:end])
    end
  end
end
