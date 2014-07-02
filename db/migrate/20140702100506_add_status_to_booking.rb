class AddStatusToBooking < ActiveRecord::Migration
  def change
    add_column :bookings, :status, :integer, default: 0
  end
end
