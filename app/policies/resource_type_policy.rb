class ResourceTypePolicy < ApplicationPolicy

  class Scope < Struct.new(:user, :scope)
    def resolve
      if user.has_role? :admin
        scope.all
      else
        scope.joins(:users).where(user_managed_resource_types: { user_id: user.id })
      end
    end
  end

  def manage?
    return false
  end

end
