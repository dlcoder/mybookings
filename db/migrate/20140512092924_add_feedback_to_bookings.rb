class AddFeedbackToBookings < ActiveRecord::Migration
  def change
    add_column :mybookings_bookings, :feedback, :text
  end
end
