class AddEventTypeToEvent < ActiveRecord::Migration[4.2]
  def change
    add_column :mybookings_events, :event_type, :string
  end
end
