class AddDisabledToResource < ActiveRecord::Migration
  def change
    add_column :resources, :disabled, :boolean, default: false
  end
end
