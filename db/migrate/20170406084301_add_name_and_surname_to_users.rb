class AddNameAndSurnameToUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :mybookings_users, :first_name, :string
    add_column :mybookings_users, :last_name, :string
  end
end
