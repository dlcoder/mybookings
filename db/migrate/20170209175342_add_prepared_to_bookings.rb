class AddPreparedToBookings < ActiveRecord::Migration[4.2]
  def change
    add_column :mybookings_bookings, :prepared, :boolean, default: false
  end
end
