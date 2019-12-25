class AddDisabledToResource < ActiveRecord::Migration[4.2]
  def change
    add_column :mybookings_resources, :disabled, :boolean, default: false
  end
end
