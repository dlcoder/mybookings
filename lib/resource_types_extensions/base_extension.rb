class ResourceTypesExtensions::BaseExtension
  def self.after_booking_creation booking
  end

  def self.on_booking_start booking
  end

  def self.on_booking_end booking
  end

  def self.actions_for booking
  end
end
