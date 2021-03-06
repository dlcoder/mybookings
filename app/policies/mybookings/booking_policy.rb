module Mybookings
  class BookingPolicy < ApplicationPolicy
    class Scope < Struct.new(:user, :scope)
      def resolve
        scope.where(user_id: user.id)
      end
    end

    def manage?
      @record.user == @user
    end
  end
end
