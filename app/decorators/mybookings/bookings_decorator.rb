module Mybookings
  class BookingsDecorator < Draper::CollectionDecorator
    delegate :name
  end
end
