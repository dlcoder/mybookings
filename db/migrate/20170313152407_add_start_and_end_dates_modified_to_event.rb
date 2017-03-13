class AddStartAndEndDatesModifiedToEvent < ActiveRecord::Migration
  def change
    add_column :mybookings_events, :start_date_advanced, :datetime
    add_column :mybookings_events, :end_date_delayed, :datetime
  end
end
