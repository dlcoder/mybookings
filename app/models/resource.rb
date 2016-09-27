class Resource < ActiveRecord::Base
  include Loggable

  belongs_to :resource_type
  has_many :events

  validates :name, :resource_type, presence: true

  delegate :name, to: :resource_type, prefix: true
  delegate :extension, to: :resource_type, prefix: true
  delegate :managed_by?, to: :resource_type, prefix: true
  delegate :users, to: :resource_type, prefix: true

  def self.available_by_resource_type resource_type
    includes(:resource_type).order('resources.name asc, resources.name asc').where(disabled: false, resource_type: resource_type)
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

  def pending_events_count
    self.events.pending.count
  end

  def occurring_events_count
    self.events.occurring.count
  end

  def expired_events_count
    self.events.expired.count
  end

  def name_prefixed_with_resource_type
    "#{self.resource_type.name}: #{self.name}"
  end
end
