class AddPreparedToBookings < ActiveRecord::Migration
  def change
    add_column :mybookings_bookings, :prepared, :boolean, default: false
  end
end
