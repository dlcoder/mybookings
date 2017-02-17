module Mybookings
  class Resource < ActiveRecord::Base
    include Loggable

    acts_as_paranoid

    belongs_to :resource_type
    has_many :events, dependent: :destroy

    validates :name, :resource_type, presence: true

    delegate :name, to: :resource_type, prefix: true
    delegate :extension, to: :resource_type, prefix: true
    delegate :managed_by?, to: :resource_type, prefix: true
    delegate :users, to: :resource_type, prefix: true

    def self.available_by_resource_type resource_type
      includes(:resource_type).order('LENGTH(mybookings_resources.name)').order('mybookings_resources.name asc').where(disabled: false, resource_type: resource_type)
    end

    def self.by_id
      order(id: :asc)
    end

    def switch_availability!
      self.update_attribute(:disabled, !self.disabled)
    end

    def bookings
      Booking.joins(:events).where(events: { resource: self })
    end

    def pending_bookings_count
      Booking.joins(:events).where(mybookings_events: { status: Event::statuses[:pending], resource_id: self }).count
    end

    def occurring_bookings_count
      Booking.joins(:events).where(mybookings_events: { status: Event::statuses[:occurring], resource_id: self }).count
    end

    def expired_bookings_count
      Booking.joins(:events).where(mybookings_events: { status: Event::statuses[:expired], resource_id: self }).count
    end

    def name_prefixed_with_resource_type
      "#{self.resource_type.name}: #{self.name}"
    end
  end
end
