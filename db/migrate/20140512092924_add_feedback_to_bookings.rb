class AddFeedbackToBookings < ActiveRecord::Migration[4.2]
  def change
    add_column :mybookings_bookings, :feedback, :text
  end
end
