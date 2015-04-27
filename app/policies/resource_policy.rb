class ResourcePolicy < ApplicationPolicy
  class Scope < Struct.new(:user, :scope)
    def resolve
      if user.has_role? :admin
        scope.all
      else
        scope.joins(:resource_type, resource_type: :users).where(user_managed_resource_types: { user_id: user.id })
      end
    end
  end

  def manage?
    return true if @user.has_role? :admin
    return @record.resource_type_managed_by? @user
  end
end
