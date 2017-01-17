class AddFeedbackToBookings < ActiveRecord::Migration
  def change
    add_column :bookings, :feedback, :text
  end
end
