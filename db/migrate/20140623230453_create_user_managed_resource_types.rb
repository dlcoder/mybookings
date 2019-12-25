class CreateUserManagedResourceTypes < ActiveRecord::Migration[4.2]
  def change
    create_table :mybookings_user_managed_resource_types do |t|
      t.belongs_to :user
      t.belongs_to :resource_type
    end
  end
end
