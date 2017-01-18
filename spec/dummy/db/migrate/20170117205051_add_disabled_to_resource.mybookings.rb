# This migration comes from mybookings (originally 20140617174840)
class AddDisabledToResource < ActiveRecord::Migration
  def change
    add_column :mybookings_resources, :disabled, :boolean, default: false
  end
end
