class AddRolesMaskToUser < ActiveRecord::Migration[4.2]
  def change
    add_column :mybookings_users, :roles_mask, :integer
  end
end
