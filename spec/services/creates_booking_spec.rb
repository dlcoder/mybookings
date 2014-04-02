require 'spec_helper'

# TODO: ok?
describe CreatesBooking do

  let(:booking_form) { BookingForm.new(start_date: '', end_date: '') }
  let(:booking) { Booking.new }
  let(:resource_id) { 1 }
  let(:resource) { Resource.new }

  before do
    allow(Booking).to receive(:new).with(start_date: booking_form.start_date, end_date: booking_form.end_date).and_return(booking)
    allow(booking_form).to receive(:resource_id).and_return(resource_id)
    allow(Resource).to receive(:find).with(resource_id).and_return(resource)
    allow(booking).to receive(:resource=).with(resource).and_return(booking)
    allow(booking).to receive(:save!).and_return(true)
  end

  it { expect( CreatesBooking.from_booking_form booking_form ).to be_true }

end
