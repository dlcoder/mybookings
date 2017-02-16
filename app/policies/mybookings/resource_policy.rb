module Mybookings
  class ResourcePolicy < ApplicationPolicy
    class Scope < Struct.new(:user, :scope)
      def resolve
        if user.has_role? :admin
          scope.all
        else
          scope.joins(:resource_type, resource_type: :users).where(mybookings_user_managed_resource_types: { user_id: user.id })
        end
      end
    end

    def manage_by_manager?
      return true if @user.has_role? :admin
      return @record.resource_type_managed_by? @user
    end

    def manage?
      return true if @user.has_role? :admin
      return @user.can_booking_resource_type? @record.resource_type
    end
  end
end
