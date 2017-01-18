class AddStatusToBooking < ActiveRecord::Migration
  def change
    add_column :mybookings_bookings, :status, :integer, default: 0
  end
end
