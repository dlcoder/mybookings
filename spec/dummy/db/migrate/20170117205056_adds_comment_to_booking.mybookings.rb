# This migration comes from mybookings (originally 20140719091017)
class AddsCommentToBooking < ActiveRecord::Migration
  def change
    add_column :mybookings_bookings, :comment, :text
  end
end
