require 'spec_helper'

describe CreatesBooking do

  let(:booking_params) { { start_date: '', end_date: '', resource_id: 1 } }
  let(:booking) { Booking.new }
  let(:resource) { Resource.new }

  before do
    allow(Booking).to receive(:new).with(booking_params).and_return(booking)
  end

  context 'when the booking params includes a resource id' do

    before do
      allow_any_instance_of(Object).to receive(:blank?).and_return(false)
      allow(Resource).to receive(:find).with(booking_params[:resource_id]).and_return(resource)
    end

    context 'when the booking params is valid' do

      before { expect(booking).to receive(:save!).and_return(true) }

      it { expect( CreatesBooking.from_booking_params booking_params ).to eq(booking) }

    end  

    context 'when the booking params is not valid' do

      before { expect(booking).to receive(:save!).and_return(false) }

      it { expect( CreatesBooking.from_booking_params booking_params ).to eq(booking) }

    end

  end

  context 'when the booking params does not includes a resource_id' do

    before do
      allow_any_instance_of(Object).to receive(:blank?).and_return(true)
    end

    it { expect( CreatesBooking.from_booking_params booking_params ).to eq(booking) }

  end

end
