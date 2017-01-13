class EventPolicy < ApplicationPolicy
  class Scope < Struct.new(:user, :scope)
    def resolve
      scope.where(user_id: user.id)
    end
  end

  def manage?
    @record.booking.user == @user
  end
end
