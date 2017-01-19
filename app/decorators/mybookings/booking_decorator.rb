module Mybookings
  class BookingDecorator < Draper::Decorator
    delegate_all

    def last_events number=4
      events.limit(number)
    end
  end
end
