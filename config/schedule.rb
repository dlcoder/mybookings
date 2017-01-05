frequency = MYBOOKINGS_CONFIG['extensions_trigger_frequency']

every frequency.minutes do
  rake 'mybookings:process_about_to_begin_bookings'
  rake 'mybookings:process_recently_finished_bookings'
  rake 'mybookings:notify_user_upcoming_bookings'
end
