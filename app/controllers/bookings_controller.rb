class BookingsController < BaseController

  # TODO: Review, http://pivotallabs.com/rails-4-testing-strong-parameters/
  class BookingParams
    def self.build params
      params.require(:booking).permit!
    end
  end

  def index; end

  def new
    @resources = Resource.all
    @booking = Booking.new
  end

  def create
    booking_params = params.require(:booking).permit!
    @booking = Booking.new(booking_params)
    @booking.resource = Resource.find(booking_params[:resource])

    return render 'new' unless @booking.save!
    return redirect_to bookings_path
  end

end
