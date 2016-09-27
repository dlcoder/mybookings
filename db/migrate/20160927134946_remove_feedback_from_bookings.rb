class RemoveFeedbackFromBookings < ActiveRecord::Migration
  def change
    remove_column :bookings, :feedback, :text
  end
end
