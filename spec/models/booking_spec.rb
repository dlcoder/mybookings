require 'rails_helper'

describe Booking do
  let(:resource) { Resource.new(name: 'Resource', resource_type: ResourceType.new ) }
  let(:booking) { Booking.new(resource: resource, start_date: 1.hour.from_now, end_date: 2.hour.from_now, user: User.new) }
  let(:booking_overlapped) { Booking.new(resource: resource, start_date: 90.minutes.from_now, end_date: 5.hour.from_now, user: User.new) }

  it 'validates that a booking with start date in the past is not valid' do
    booking.start_date = 2.hour.ago

    expect(booking.valid?).to be false
    expect(booking).to have(1).errors_on(:start_date)
  end

  it 'validates that a booking with end date in the past is not valid' do
    booking.start_date = 2.hour.ago
    booking.end_date = 1.hour.ago

    expect(booking.valid?).to be false
    expect(booking).to have(1).errors_on(:end_date)
  end

  it 'validates that a booking with start date greater than end date is not valid' do
    booking.start_date = 2.day.from_now
    booking.end_date = 1.day.from_now

    expect(booking.valid?).to be false
    expect(booking).to have(1).errors_on(:start_date)
    expect(booking).to have(1).errors_on(:end_date)
  end

  it 'validates that a resource can not be reserved more than one time in the same time slot' do
    booking.save!

    expect(booking_overlapped.valid?).to be false
    expect(booking_overlapped).to have(1).errors
  end
end
