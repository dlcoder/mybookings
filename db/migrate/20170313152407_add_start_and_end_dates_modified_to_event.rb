class AddStartAndEndDatesModifiedToEvent < ActiveRecord::Migration[4.2]
  def change
    add_column :mybookings_events, :start_date_advanced, :datetime
    add_column :mybookings_events, :end_date_delayed, :datetime
  end
end
