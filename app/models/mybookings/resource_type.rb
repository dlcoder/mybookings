module Mybookings
  class ResourceType < ActiveRecord::Base
    include ::RoleModel
    include Loggable

    acts_as_paranoid

    has_one :booking
    has_many :resources, dependent: :destroy
    has_and_belongs_to_many :users, join_table: 'mybookings_user_managed_resource_types'

    serialize :notifications_emails, Array

    validates :name, :extension, presence: true
    validates :notifications_email_from, email: true
    validates :notifications_emails, email_list: true
    validates :minutes_in_advance, :minutes_of_grace, :limit_hours_duration, :limit_days_for_recurring_events, :limit_days_for_feedback, numericality: { greater_than: 0 }

    roles [:admin, :manager] + MYBOOKINGS_CONFIG['extra_roles']

    def self.by_name
      order(name: :asc)
    end

    def resources_number
      self.resources.count
    end

    def managed_by? user
      self.users.exists? user.id
    end

    def has_roles?
      roles_mask != 0
    end

    def use_by_resource
      event_duration = "strftime('%H', mybookings_events.end_date) - strftime('%H', mybookings_events.start_date)"
      event_duration = "HOUR(mybookings_events.end_date) - HOUR(mybookings_events.start_date)" if ActiveRecord::Base.connection.adapter_name != 'SQLite'

      ResourceType.joins(resources: [:events]).select(resources: [:name]).where(id: self).group('mybookings_resources.name').sum(event_duration)
    end

    def use_by_hour
      query_string = "strftime('%H', mybookings_events.start_date)"
      query_string = "HOUR(mybookings_events.start_date)" if ActiveRecord::Base.connection.adapter_name != 'SQLite'

      ResourceType.joins(resources: [:events]).select(query_string).where(id: self).group(query_string).count
    end
  end
end
