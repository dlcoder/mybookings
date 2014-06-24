class Resource < ActiveRecord::Base
  belongs_to :resource_type
  has_many :bookings

  validates :name, :resource_type, presence: true

  delegate :name, to: :resource_type, prefix: true
  delegate :managed_by?, to: :resource_type, prefix: true

  def self.avalaible_by_type_name_and_name
    includes(:resource_type).order('resource_types.name asc, resources.name asc').where(disabled: false)
  end

  def self.by_id
    order(id: :asc)
  end

  def switch_availability!
    self.disabled = !self.disabled
    self.save!
  end

  def disabled?
    self.disabled
  end

  def pending_bookings_count
    Booking.pending_by_resource(self).count
  end

  def name_prefixed_with_resource_type
    "#{self.resource_type.name}: #{self.name}"
  end
end
