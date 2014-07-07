require File.expand_path('../../config/boot',        __FILE__)
require File.expand_path('../../config/environment', __FILE__)
require 'clockwork'

include Clockwork

every(MYBOOKINGS_CONFIG['extensions_trigger_frequency'].minutes, 'extensions_triggers') do

  about_to_begin_bookings = Booking.about_to_begin
  recently_finished_bookings = Booking.recently_finished

  about_to_begin_bookings.each do |booking|
    booking.occurring!
    ResourceTypesExtensionsWrapper.call(booking.resource_resource_type_extension, :on_booking_start, booking)
  end

  recently_finished_bookings.each do |booking|
    booking.expired!
    ResourceTypesExtensionsWrapper.call(booking.resource_resource_type_extension, :on_booking_end, booking)
  end

end
