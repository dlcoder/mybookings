module Mybookings
  class Backend::ResourceTypesController < Backend::BaseController
    include Backend::Administerable
    include Backend::Authorizable

    before_action :load_resource_type, only: [:edit, :update]
    before_action :load_valid_roles, only: [:new, :edit, :create, :update]

    def index
      @resource_types = ResourceType.all
    end

    def new
      @resource_type = ResourceType.new
    end

    def create
      @resource_type = ResourceType.new(resource_type_params)
      return render 'new' unless @resource_type.valid?
      @resource_type.save!
      return redirect_to backend_resource_types_path
    end

    def edit; end

    def update
      return render 'edit' unless @resource_type.update_attributes(resource_type_params)
      return redirect_to backend_resource_types_path
    end

    private

    def resource_type_params
      params.require(:resource_type).permit!
    end

    def load_resource_type
      resource_type_id = params[:id] || params[:resource_type_id]

      @resource_type = ResourceType.find(resource_type_id)
    end

    def load_valid_roles
      @valid_roles = ResourceType.valid_roles
    end
  end
end
