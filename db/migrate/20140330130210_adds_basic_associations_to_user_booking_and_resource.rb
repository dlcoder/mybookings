class AddsBasicAssociationsToUserBookingAndResource < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.belongs_to :user
      t.belongs_to :resource
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end

    add_index :bookings, [ :user_id, :resource_id ]

    create_table :resources do |t|
      t.string :name

      t.timestamps
    end

    add_index :resources, :name
  end
end
