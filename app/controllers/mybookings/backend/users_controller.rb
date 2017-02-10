module Mybookings
  class Backend::UsersController < Backend::BaseController
    include Backend::Administerable
    include Backend::Authorizable

    before_action :load_user, only: [:edit, :update]
    before_action :load_valid_roles, only: [:new, :edit]
    before_action :load_resource_types, only: [:new, :edit]

    def index
      @users = User.by_id
    end

    def new
      @user = User.new
    end

    def create
      @user = User.new(user_params)
      @user.password = Devise.friendly_token.first(8)

      if @user.valid?
        @user.save!
        return redirect_to backend_users_path
      end

      load_valid_roles
      load_resource_types
      render 'new'
    end

    def edit; end

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
      params.require(:user).permit(:email, :roles => [], :resource_type_ids => [])
    end
  end
end
