class CreateEvents < ActiveRecord::Migration
  def change

    create_table :events do |t|
      t.datetime    :start_date
      t.datetime    :end_date
      t.integer     :status,    null: false, default: 0
      t.text        :feedback
      t.belongs_to  :booking,   index: true
      t.belongs_to  :resource,  index: true
    end

    remove_column     :bookings, :start_date,     :datetime
    remove_column     :bookings, :end_date,       :datetime
    remove_reference  :bookings, :resource,       index: true
    add_reference     :bookings, :resource_type,  index: true
    remove_column     :bookings, :status,         :integer
    remove_column     :bookings, :feedback,       :text

  end
end
