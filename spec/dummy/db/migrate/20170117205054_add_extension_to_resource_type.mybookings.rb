# This migration comes from mybookings (originally 20140629115624)
class AddExtensionToResourceType < ActiveRecord::Migration
  def change
    add_column :mybookings_resource_types, :extension, :string, default: 'DefaultExtension'
  end
end
