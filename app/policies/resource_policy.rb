class ResourcePolicy < ApplicationPolicy

  class Scope < Struct.new(:user, :scope)
    def resolve
      if user.has_role? :admin
        scope.all
      else
        # TODO: Review this query. Perhaps there is another way more efficient
        # Generated SQL:
        #
        # SELECT "resources".* FROM "resources"
        #   INNER JOIN "resource_types" ON "resource_types"."id" = "resources"."resource_type_id"
        #   INNER JOIN "user_managed_resource_types" ON "user_managed_resource_types"."resource_type_id" = "resource_types"."id"
        #   INNER JOIN "users" ON "users"."id" = "user_managed_resource_types"."user_id" WHERE "user_managed_resource_types"."user_id" = 2
        # ORDER BY "resources"."id" ASC
        scope.joins(:resource_type, resource_type: :users).where(user_managed_resource_types: { user_id: user.id })
      end
    end
  end

  def manage?
    return true if @user.has_role? :admin
    return @record.resource_type_managed_by? @user
  end

end
