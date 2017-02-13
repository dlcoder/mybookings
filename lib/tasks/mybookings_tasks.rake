namespace :mybookings do
  desc "Process bookings planning"
  task process_bookings_planning: :environment do
    Mybookings::Booking.unprepared.each do |booking|
      booking.prepare!
    end

    Mybookings::Event.upcoming.each do |event|
      event.start!
      Mybookings::NotificationsMailer.notify_upcoming_booking(event.booking).deliver!
    end

    Mybookings::Event.finished.each do |event|
      event.end!
    end
  end
end
