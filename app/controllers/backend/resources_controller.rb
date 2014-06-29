class Backend::ResourcesController < Backend::BaseController

  include Backend::Administerable
  include Backend::Manageable
  include Backend::Authorizable

  before_action :load_resource, only: [:switch_availability]

  def index
    @resources = policy_scope(Resource).by_id
  end

  def switch_availability
    @resource.switch_availability!
    return redirect_to backend_resources_path
  end

  def new
    @resource = Resource.new
    load_current_user_managed_resource_types
  end

  def create
    @resource = Resource.new(resource_params)
    authorize @resource

    return redirect_to backend_resources_path if @resource.save

    load_current_user_managed_resource_types
    render 'new'
  end

  private

  def resource_params
    params.require(:resource).permit!
  end

  def load_resource
    resource_id = params[:id] || params[:resource_id]

    @resource = Resource.find(resource_id)
    authorize @resource
  end

  def load_current_user_managed_resource_types
    @managed_resource_types = policy_scope(ResourceType)
  end

end
