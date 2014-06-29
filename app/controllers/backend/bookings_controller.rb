class Backend::BookingsController < Backend::BaseController

  include Backend::Administerable
  include Backend::Manageable
  include Backend::Authorizable

  before_action :load_resource, only: [:index]

  def index
    @bookings = @resource.bookings
  end
  
  private

  def load_resource
    resource_id = params[:resource_id]

    @resource = Resource.find(resource_id)
    authorize @resource
  end

end
