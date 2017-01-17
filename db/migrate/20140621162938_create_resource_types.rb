class CreateResourceTypes < ActiveRecord::Migration
  def change
    create_table :resource_types do |t|
      t.string :name

      t.timestamps
    end

    add_column :resources, :resource_type_id, :integer
  end
end
