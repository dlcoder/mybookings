require 'spec_helper'

describe Booking do
  let(:resource) { Resource.new(name: 'Resource', resource_type: ResourceType.new ) }
  let(:event) { Event.new(start_date: 1.hour.from_now, end_date: 2.hour.from_now) }
  let(:booking) { Booking.new(resource: resource, events: [event], user: User.new) }
  let(:event_overlapped) { Event.new(start_date: 90.minutes.from_now, end_date: 5.hour.from_now) }
  let(:booking_overlapped) { Booking.new(resource: resource, events: [event_overlapped], user: User.new) }

  it 'validates that a resource can not be reserved more than one time in the same time slot' do
    booking.save!

    expect(booking_overlapped.valid?).to be_false
    expect(booking_overlapped).to have(1).errors
  end
end
