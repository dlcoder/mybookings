class BookingsDecorator < Draper::CollectionDecorator
  delegate :name
end
