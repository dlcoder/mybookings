class AddExtensionToResourceType < ActiveRecord::Migration
  def change
    add_column :resource_types, :extension, :string, default: 'DefaultExtension'
  end
end
