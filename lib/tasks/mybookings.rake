namespace :mybookings do

  desc "Process about to begin bookings"
  task process_about_to_begin_bookings: :environment do

    about_to_begin_bookings = Booking.about_to_begin

    about_to_begin_bookings.each do |booking|
      booking.occurring!
      ResourceTypesExtensionsWrapper.call(:on_booking_start, booking)
    end

  end

  desc "Process recently finished bookings"
  task process_recently_finished_bookings: :environment do

    recently_finished_bookings = Booking.recently_finished

    recently_finished_bookings.each do |booking|
      booking.expired!
      ResourceTypesExtensionsWrapper.call(:on_booking_end, booking)
    end

  end

end
