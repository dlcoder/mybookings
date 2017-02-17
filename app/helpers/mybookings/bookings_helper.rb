module Mybookings
  module BookingsHelper
    def bootstrap_class_for booking_status
      return 'success' if booking_status == 'pending'
      return 'info' if booking_status == 'occurring'
      return 'default' if booking_status == 'expired'
    end

    def recurrent_types_list
      Mybookings::Booking::recurrent_types.collect do |type, value|
        [ I18n.t("mybookings.bookings.recurrent_types.#{type}"), type ]
      end
    end
  end
end
