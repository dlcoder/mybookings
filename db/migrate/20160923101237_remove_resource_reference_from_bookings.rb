class RemoveResourceReferenceFromBookings < ActiveRecord::Migration
  def change
    remove_reference :bookings, :resource, index: true
  end
end
