module Mybookings
  class BookingDecorator < Draper::Decorator
    delegate_all

    def last_events number=4
      events.limit(number)
    end

    def has_more_than_four_events?
      events.size > 4
    end
  end
end
