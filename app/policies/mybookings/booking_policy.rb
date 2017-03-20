module Mybookings
  class BookingPolicy < ApplicationPolicy
    class Scope < Struct.new(:user, :scope)
      def resolve
        scope.where(user_id: user.id)
      end
    end

    def manage?
      return true if @user.has_role? :admin
      return true if (@user.has_role?(:manager) && @record.resource_type_managed_by?(@user))
      @record.user == @user
    end
  end
end
