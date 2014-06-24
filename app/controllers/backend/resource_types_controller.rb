class Backend::ResourceTypesController < Backend::BaseController

  include Administerable
  include Authorizable

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

  private

  def resource_type_params
    params.require(:resource_type).permit!
  end

end
