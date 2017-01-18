# This migration comes from mybookings (originally 20140512092924)
class AddFeedbackToBookings < ActiveRecord::Migration
  def change
    add_column :mybookings_bookings, :feedback, :text
  end
end
