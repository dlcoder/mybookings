module Mybookings
  class BookingDecorator < Draper::Decorator
    delegate_all
  end
end
