class AddsCommentToBooking < ActiveRecord::Migration
  def change
    add_column :bookings, :comment, :text
  end
end
