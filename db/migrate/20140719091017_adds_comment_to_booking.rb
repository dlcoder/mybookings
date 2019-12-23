class AddsCommentToBooking < ActiveRecord::Migration[4.2]
  def change
    add_column :mybookings_bookings, :comment, :text
  end
end
