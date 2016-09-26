class AddStatusToEvents < ActiveRecord::Migration
  def change
    add_column :events, :status, :integer, null: false, default: 0
  end
end
