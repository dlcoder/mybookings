class AddsCommentToBooking < ActiveRecord::Migration
  def change
    add_column :mybookings_bookings, :comment, :text
  end
end
