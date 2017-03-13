class AddConfigurationAttributesToResourceType < ActiveRecord::Migration
  def change
    add_column :mybookings_resource_types, :notifications_email_from, :string
    add_column :mybookings_resource_types, :notifications_emails, :text
    add_column :mybookings_resource_types, :minutes_in_advance, :integer, default: 1
    add_column :mybookings_resource_types, :minutes_of_grace, :integer, default: 1
    add_column :mybookings_resource_types, :limit_hours_duration, :integer, default: 24
    add_column :mybookings_resource_types, :limit_days_for_recurring_events, :integer, default: 365
    add_column :mybookings_resource_types, :limit_days_for_feedback, :integer, default: 7
  end
end
