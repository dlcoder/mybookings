module Mybookings
  class Backend::BookingsController < Backend::BaseController
    include Backend::Administerable
    include Backend::Manageable
    include Backend::Authorizable

    before_action :load_booking, only: [:show]

    def show; end

    private

    def load_booking
      @booking = Booking.find(params[:id]).decorate
    end

  end
end
