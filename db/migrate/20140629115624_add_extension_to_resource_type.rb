class AddExtensionToResourceType < ActiveRecord::Migration
  def change
    add_column :mybookings_resource_types, :extension, :string, default: 'DefaultExtension'
  end
end
