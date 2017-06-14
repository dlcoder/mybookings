module Mybookings
  class ResourceTypePolicy < ApplicationPolicy
    class Scope < Struct.new(:user, :scope)
      def resolve
        return scope.all if user.has_role? :admin
        scope.where(roles_mask: [0] + user.get_all_posibles_masks_for_roles)
      end

      def resolve_for_managers
        return scope.all if user.has_role? :admin
        scope.joins(:users).where(mybookings_user_managed_resource_types: { user_id: user.id }) if user.has_role? :manager
      end
    end

    def manage?
      return true if @user.has_role? :admin
      return true if (@user.has_role?(:manager) && @record.managed_by?(@user))
      return false
    end
  end
end
