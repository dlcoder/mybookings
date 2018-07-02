namespace :mybookings do
  desc "Process bookings planning"
  task process_bookings_planning: :environment do
    Mybookings::Booking.unprepared.each do |booking|
      booking.prepare!
      Mybookings::ConfirmationsMailer.new_booking_to_user(booking).deliver_now!
      if booking.resource_type_notifications_emails.any?
        Mybookings::ConfirmationsMailer.new_booking_to_resource_type_managers(booking).deliver_now!
      end
    end

    Mybookings::Event.upcoming.each do |event|
      event.start!
      Mybookings::RemindersMailer.upcoming_event_to_user(event).deliver_now!
    end

    Mybookings::Event.finished.each do |event|
      event.end!
    end
  end
end
