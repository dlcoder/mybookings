module Mybookings
  class Backend::StatisticsController < Backend::BaseController
    include Backend::Administerable
    include Backend::Manageable
    include Backend::Authorizable

    before_action :load_current_user_managed_resource_types, only: [:by_resource, :by_hour]

    def index; end

    def by_resource
      @statistics_form = StatisticsForm.new({ resource_type_id: @resource_types.first.id })
    end

    def by_hour
      @statistics_form = StatisticsForm.new({ resource_type_id: @resource_types.first.id })
    end

    private

    def load_current_user_managed_resource_types
      @resource_types = ResourceTypePolicy::Scope.new(current_user, ResourceType).resolve_for_managers
    end
  end
end
