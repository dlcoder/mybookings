module Mybookings
  class BookingDecorator < Draper::Decorator
    delegate_all

    def limit_recent_events_to number=4
       events.recents[0..number-1]
    end

    def has_more_than? number=4
      events.size > number
    end
  end
end
