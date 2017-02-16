module Mybookings
  class BookingDecorator < Draper::Decorator
    delegate_all

    decorates_association :events

    def latest_events number
       EventDecorator.decorate_collection(object.events.recents[0..number-1])
    end

    def events_count_greater_than? number
      object.events.size > number
    end
  end
end
