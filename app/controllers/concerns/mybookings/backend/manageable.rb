module Mybookings
  module Backend::Manageable
    extend ActiveSupport::Concern

    included do
      before_action :authorize_if_manager
    end

    private

    def authorize_if_manager
      @authorized = true if current_user.has_role? :manager
    end
  end
end
