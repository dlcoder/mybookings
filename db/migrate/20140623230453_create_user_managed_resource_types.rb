class CreateUserManagedResourceTypes < ActiveRecord::Migration
  def change
    create_table :user_managed_resource_types do |t|
      t.belongs_to :user
      t.belongs_to :resource_type
    end
  end
end
