module Mybookings
  class UserPolicy < ApplicationPolicy
    class Scope < Struct.new(:user, :scope)
      def resolve
        scope.all
      end
    end

    def manage?
      return true if @user.has_role? :admin
      return false
    end
  end
end
