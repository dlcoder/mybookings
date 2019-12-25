class AddHideCommentFieldToResourceType < ActiveRecord::Migration[4.2]
  def change
    add_column :mybookings_resource_types, :hide_comment_field, :boolean, default: false
  end
end
