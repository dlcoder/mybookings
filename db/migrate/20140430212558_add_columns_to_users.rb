class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :mybookings_users, :provider, :string
    add_column :mybookings_users, :uid, :string
  end
end
