class ResourceTypesExtensions::BaseExtension

  def self.after_booking_creation booking
  end

  def self.on_booking_start booking
    booking.occurring!
  end

  def self.on_booking_end booking
    booking.expired!
  end

end
