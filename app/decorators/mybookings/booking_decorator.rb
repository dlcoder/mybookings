module Mybookings
  class BookingDecorator < Draper::Decorator
    delegate_all

    decorates_association :events

    def limit_recent_events_to number=4
       EventDecorator.decorate_collection(object.events.recents[0..number-1])
    end

    def has_more_than? number=4
      object.events.size > number
    end
  end
end
