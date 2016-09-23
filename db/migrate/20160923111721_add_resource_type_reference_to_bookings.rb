class AddResourceTypeReferenceToBookings < ActiveRecord::Migration
  def change
    add_reference :bookings, :resource_type, index: true
  end
end
