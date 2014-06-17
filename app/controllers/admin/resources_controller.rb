class Admin::ResourcesController < Admin::BaseController
  before_action :load_resource, only: [:switch_availability]

  def index
    @resources = Resource.all.by_availability.by_id
  end

  def new; end

  def switch_availability
    @resource.switch_availability!
    redirect_to admin_resources_path
  end

  private

  def load_resource
    resource_id = params[:id] || params[:resource_id]

    @resource = Resource.find(resource_id)
  end
end
