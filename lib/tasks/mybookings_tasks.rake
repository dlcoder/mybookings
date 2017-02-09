namespace :mybookings do

  desc "Process unprepared bookings"
  task process_unprepared_bookings: :environment do
    unprepared_bookings = Booking.where(unprepared: true)

    unprepared_bookings.each do |booking|
      booking.prepare!
    end
  end

  desc "Process about to begin events"
  task process_about_to_begin_events: :environment do
    about_to_begin_events = Event.about_to_begin

    about_to_begin_events.each do |event|
      event.occurring!
      event.start!
    end
  end

  desc "Process recently finished events"
  task process_recently_finished_events: :environment do
    recently_finished_events = Event.recently_finished

    recently_finished_events.each do |event|
      event.expired!
      event.end!
    end
  end

  desc "Notify user upcoming bookings"
  task notify_user_upcoming_bookings: :enviroment do
    upcoming_bookings = Booking.upcoming

    upcoming_bookings.each do |booking|
      NotificationsMailer.notify_upcoming_booking(booking).deliver!
    end
  end

end
