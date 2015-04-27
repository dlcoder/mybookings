class Backend::UsersController < Backend::BaseController
  include Backend::Administerable
  include Backend::Authorizable

  before_action :load_user, only: [:edit, :update]

  def index
    @users = User.by_id
  end

  def edit
    load_valid_roles
    load_resource_types
  end

  def update
    return redirect_to backend_users_path if @user.update(user_params)
    load_valid_roles
    load_resource_types
    render 'edit'
  end

  private

  def load_user
    user_id = params[:id] || params[:user_id]

    @user = User.find(user_id)
  end

  def load_valid_roles
    @valid_roles = User.valid_roles
  end

  def load_resource_types
    @resource_types = ResourceType.by_name
  end

  def user_params
    params.require(:user).permit(:roles, :resource_type_ids => [])
  end
end
