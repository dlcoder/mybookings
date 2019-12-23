class CreateResourceTypes < ActiveRecord::Migration[4.2]
  def change
    create_table :mybookings_resource_types do |t|
      t.string :name

      t.timestamps
    end

    add_column :mybookings_resources, :resource_type_id, :integer
  end
end
