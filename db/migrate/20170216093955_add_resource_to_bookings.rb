class AddResourceToBookings < ActiveRecord::Migration
  def change
    add_reference :mybookings_bookings, :proposed_resource,  index: true
  end
end
