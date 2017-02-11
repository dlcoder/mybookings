class AddRolesMaskToResourceType < ActiveRecord::Migration
  def change
    add_column :mybookings_resource_types, :roles_mask, :integer
  end
end
