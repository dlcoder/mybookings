class AddResourceToBookings < ActiveRecord::Migration[4.2]
  def change
    add_reference :mybookings_bookings, :proposed_resource,  index: true
  end
end
