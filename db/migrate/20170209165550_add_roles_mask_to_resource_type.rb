class AddRolesMaskToResourceType < ActiveRecord::Migration[4.2]
  def change
    add_column :mybookings_resource_types, :roles_mask, :integer
  end
end
