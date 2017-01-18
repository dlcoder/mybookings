# This migration comes from mybookings (originally 20160922144800)
class CreateEvents < ActiveRecord::Migration
  def change
    create_table :mybookings_events do |t|
      t.datetime    :start_date
      t.datetime    :end_date
      t.integer     :status,    null: false, default: 0
      t.text        :feedback
      t.belongs_to  :booking,   index: true
      t.belongs_to  :resource,  index: true
    end

    remove_column     :mybookings_bookings, :start_date,     :datetime
    remove_column     :mybookings_bookings, :end_date,       :datetime
    remove_column     :mybookings_bookings, :status,         :integer
    remove_column     :mybookings_bookings, :feedback,       :text
    remove_reference  :mybookings_bookings, :resource,       index: true
    add_reference     :mybookings_bookings, :resource_type,  index: true
  end
end
