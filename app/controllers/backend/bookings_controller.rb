class Backend::BookingsController < Backend::BaseController

  include Administerable
  include Manageable
  include Authorizable

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
