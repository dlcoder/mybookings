module Mybookings
  class EventPolicy < ApplicationPolicy
    class Scope < Struct.new(:user, :scope)
      def resolve
        scope.where(user_id: user.id)
      end
    end

    def manage?
      return true if @user.has_role? :admin
      return @record.resource.resource_type_managed_by? @user
    end
  end
end
