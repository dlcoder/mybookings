module Mybookings
  class Backend::StatisticsController < Backend::BaseController
    include Backend::Administerable
    include Backend::Authorizable
    include Backend::Manageable

    def index; end

    def by_resource
      @resource_types = ResourceType.all
      @statistics_form = ResourceStatisticsForm.new({ resource_type_id: @resource_types.first.id })
    end

    def by_hour
      @resource_types = ResourceType.all
      @statistics_form = ResourceStatisticsForm.new({ resource_type_id: @resource_types.first.id })
    end
  end
end
