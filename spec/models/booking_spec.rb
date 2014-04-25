require 'spec_helper'

describe Booking do
  let(:booking) { Booking.new(resource: Resource.new, start_date: 1.hour.from_now, end_date: 2.hour.from_now) }

  it 'validates that a booking with start date in the past is not valid' do
    booking.start_date = 2.hour.ago

    expect(booking.valid?).to be_false
    expect(booking).to have(1).errors_on(:start_date)
  end

  it 'validates that a booking with end date in the past is not valid' do
    booking.start_date = 2.hour.ago
    booking.end_date = 1.hour.ago

    expect(booking.valid?).to be_false
    expect(booking).to have(1).errors_on(:end_date)
  end

  it 'validates that a booking with start date greater than end date is not valid' do
    booking.start_date = 2.day.from_now
    booking.end_date = 1.day.from_now

    expect(booking.valid?).to be_false
    expect(booking).to have(1).errors_on(:start_date)
    expect(booking).to have(1).errors_on(:end_date)
  end
end
