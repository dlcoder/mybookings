class ResourceTypePolicy < ApplicationPolicy

  class Scope < Struct.new(:user, :scope)
    def resolve
      if user.has_role? :admin
        scope.all
      else
        # TODO: Review this query. Perhaps there is another way more efficient
        # Generated SQL:
        # 
        #   SELECT "resource_types".* FROM "resource_types"
        #     INNER JOIN "user_managed_resource_types" ON "user_managed_resource_types"."resource_type_id" = "resource_types"."id"
        #     INNER JOIN "users" ON "users"."id" = "user_managed_resource_types"."user_id" WHERE "user_managed_resource_types"."user_id" = 2
        scope.joins(:users).where(user_managed_resource_types: { user_id: user.id })
      end
    end
  end

  def manage?
    return false
  end

end
