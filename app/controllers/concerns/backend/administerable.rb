module Backend::Administerable

  extend ActiveSupport::Concern

  included do
    before_action :authorize_if_admin
  end

  private

  def authorize_if_admin
    @authorized = true if current_user.has_role? :admin
  end

end
