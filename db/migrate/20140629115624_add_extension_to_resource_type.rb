class AddExtensionToResourceType < ActiveRecord::Migration[4.2]
  def change
    add_column :mybookings_resource_types, :extension, :string, default: 'DefaultExtension'
  end
end
