class AddEventTypeToEvent < ActiveRecord::Migration
  def change
    add_column :mybookings_events, :event_type, :string
  end
end
