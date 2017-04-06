class AddNameAndSurnameToUsers < ActiveRecord::Migration
  def change
    add_column :mybookings_users, :first_name, :string
    add_column :mybookings_users, :last_name, :string
  end
end
