class AddDeletedAtToModels < ActiveRecord::Migration
  def change
    add_column :mybookings_bookings,        :deleted_at, :datetime
    add_column :mybookings_events,          :deleted_at, :datetime
    add_column :mybookings_resource_types,  :deleted_at, :datetime
    add_column :mybookings_resources,       :deleted_at, :datetime
    add_column :mybookings_users,           :deleted_at, :datetime

    add_index :mybookings_bookings,       :deleted_at
    add_index :mybookings_events,         :deleted_at
    add_index :mybookings_resource_types, :deleted_at
    add_index :mybookings_resources,      :deleted_at
    add_index :mybookings_users,          :deleted_at
  end
end
