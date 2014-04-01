require 'spec_helper'

describe CreatesBooking do

  let(:booking_params) { {} }
  let(:booking) { Booking.new }
  let(:resource) { Resource.new }

  before do
    allow(Booking).to receive(:new).with(booking_params).and_return(booking)
    allow(Resource).to receive(:find).with(booking_params[:resource_id]).and_return(resource)
  end

  context 'when the booking params is valid' do

    before { allow(booking).to receive(:save!).and_return(true) }

    it { expect( CreatesBooking.from_booking_params booking_params ).to eq(true) }

  end  

  context 'when the booking params is not valid' do

    before { allow(booking).to receive(:save!).and_return(false) }

    it { expect( CreatesBooking.from_booking_params booking_params ).to eq(false) }

  end

end
