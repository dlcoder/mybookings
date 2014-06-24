class Admin::ResourceTypesController < Admin::BaseController

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
    return redirect_to admin_resource_types_path
  end

  private

  def resource_type_params
    params.require(:resource_type).permit!
  end

end
