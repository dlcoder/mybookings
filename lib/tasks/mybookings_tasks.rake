namespace :mybookings do
  desc "Process bookings planning"
  task process_bookings_planning: :environment do
    Mybookings::Booking.unprepared.each do |booking|
      booking.prepare!
    end

    Mybookings::Event.upcoming.each do |event|
      event.start!
      Mybookings::NotificationsMailer.upcoming_event(event, event.booking_user_email).deliver_now!
    end

    Mybookings::Event.finished.each do |event|
      event.end!
    end
  end
end
