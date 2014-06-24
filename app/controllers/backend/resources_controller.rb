class Backend::ResourcesController < Backend::BaseController

  include Administerable
  include Manageable
  include Authorizable

  before_action :load_resource, only: [:switch_availability]

  def index
    @resources = Resource.by_id
  end

  def switch_availability
    @resource.switch_availability!
    return redirect_to backend_resources_path
  end

  def new
    @resource = Resource.new
  end

  def create
    @resource = Resource.new(resource_params)
    return render 'new' unless @resource.valid?
    @resource.save!
    return redirect_to backend_resources_path
  end

  private

  def resource_params
    params.require(:resource).permit!
  end

  def load_resource
    resource_id = params[:id] || params[:resource_id]

    @resource = Resource.find(resource_id)
  end

end
