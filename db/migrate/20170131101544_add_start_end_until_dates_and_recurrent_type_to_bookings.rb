class AddStartEndUntilDatesAndRecurrentTypeToBookings < ActiveRecord::Migration[4.2]
  def change
    add_column :mybookings_bookings, :start_date,     :datetime
    add_column :mybookings_bookings, :end_date,       :datetime
    add_column :mybookings_bookings, :until_date,     :datetime
    add_column :mybookings_bookings, :recurrent_type, :integer, default: 0
  end
end
