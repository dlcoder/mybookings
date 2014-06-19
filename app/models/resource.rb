class Resource < ActiveRecord::Base
  has_many :bookings

  def self.available
    where(disabled: false)
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
end
