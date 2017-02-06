require 'rails_helper'

module Mybookings
  describe Booking do
    let(:resource) { Resource.new(name: 'Resource', resource_type: ResourceType.new ) }
    let(:event) { Event.new(resource: resource, start_date: 1.hour.from_now, end_date: 2.hour.from_now) }
    let(:booking) { Booking.new(events: [event], user: User.new, start_date: 1.hour.from_now, end_date: 2.hour.from_now, resource_id: '1') }
    let(:event_overlapped) { Event.new(resource: resource, start_date: 90.minutes.from_now, end_date: 5.hour.from_now) }
    let(:booking_overlapped) { Booking.new(events: [event_overlapped], user: User.new, start_date: 90.minutes.from_now, end_date: 5.hour.from_now, resource_id: '1') }
    let(:booking_without_resource) { Booking.new(events: [event], user: User.new) }

    it 'validates that a resource can not be reserved more than one time in the same time slot' do
      booking.save!

      expect(booking_overlapped.valid?).to be false
      expect(booking_overlapped).to have(1).errors
    end

  end
end
