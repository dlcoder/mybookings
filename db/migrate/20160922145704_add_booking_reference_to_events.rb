class AddBookingReferenceToEvents < ActiveRecord::Migration
  def change
    add_reference :events, :booking, index: true
  end
end
