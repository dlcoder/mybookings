class AddBookingTypeToBookings < ActiveRecord::Migration[4.2]
  def change
    add_column :mybookings_bookings, :booking_type, :string
  end
end
