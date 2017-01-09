class CreateEvents < ActiveRecord::Migration
  def change

    create_table :events do |t|
      t.datetime :start_date
      t.datetime :end_date
    end

    add_reference :events, :booking, index: true

    remove_column :bookings, :start_date, :datetime
    remove_column :bookings, :end_date, :datetime

    remove_reference :bookings, :resource, index: true

    add_reference :events, :resource, index: true

    add_reference :bookings, :resource_type, index: true

    remove_column :bookings, :status, :integer

    add_column :events, :status, :integer, null: false, default: 0

    remove_column :bookings, :feedback, :text

    add_column :events, :feedback, :text

  end
end
