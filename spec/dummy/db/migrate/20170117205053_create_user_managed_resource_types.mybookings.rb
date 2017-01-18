# This migration comes from mybookings (originally 20140623230453)
class CreateUserManagedResourceTypes < ActiveRecord::Migration
  def change
    create_table :mybookings_user_managed_resource_types do |t|
      t.belongs_to :user
      t.belongs_to :resource_type
    end
  end
end
