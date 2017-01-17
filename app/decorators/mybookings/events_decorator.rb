module Mybookings
  class EventsDecorator < Draper::CollectionDecorator
    delegate_all
  end
end
