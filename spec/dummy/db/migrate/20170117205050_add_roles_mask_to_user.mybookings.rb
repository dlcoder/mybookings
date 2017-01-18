# This migration comes from mybookings (originally 20140617110448)
class AddRolesMaskToUser < ActiveRecord::Migration
  def change
    add_column :mybookings_users, :roles_mask, :integer
  end
end
