class AddStatusToBooking < ActiveRecord::Migration[4.2]
  def change
    add_column :mybookings_bookings, :status, :integer, default: 0
  end
end
