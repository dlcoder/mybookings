class AddBookingTypeToBookings < ActiveRecord::Migration
  def change
    add_column :mybookings_bookings, :booking_type, :string
  end
end
