class AddResourceReferenceToEvents < ActiveRecord::Migration
  def change
    add_reference :events, :resource, index: true
  end
end
