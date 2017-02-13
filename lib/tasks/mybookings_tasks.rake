namespace :mybookings do
  desc "Process bookings planning"
  task process_bookings_planning: :environment do
    Mybookings::Booking.unprepared.each { |booking| booking.prepare! }
    Mybookings::Event.upcoming.each { |event| event.start! }
    Mybookings::Event.finished.each { |event| event.end! }
  end
end
