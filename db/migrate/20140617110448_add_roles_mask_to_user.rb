class AddRolesMaskToUser < ActiveRecord::Migration
  def change
    add_column :mybookings_users, :roles_mask, :integer
  end
end
