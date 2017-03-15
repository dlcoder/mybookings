require 'spec_helper'

module Mybookings
  describe Event do
    let(:resource) { Resource.new(name: 'Resource', resource_type: ResourceType.new ) }
    let(:booking) { Booking.new }
    let(:event) { Event.new(booking: booking, resource: resource, start_date: 1.hour.from_now, end_date: 2.hour.from_now) }

    before do
      allow(booking).to receive(:resource_type_minutes_in_advance).and_return(30)
      allow(booking).to receive(:resource_type_minutes_of_grace).and_return(30)
    end

    it 'validates that a event with start date in the past is not valid' do
      event.start_date = 2.hour.ago

      expect(event.valid?).to be false
      expect(event).to have(1).errors_on(:start_date)
    end

    it 'validates that a event with end date in the past is not valid' do
      event.start_date = 2.hour.ago
      event.end_date = 1.hour.ago

      expect(event.valid?).to be false
      expect(event).to have(1).errors_on(:end_date)
    end

    it 'validates that a event with start date greater than end date is not valid' do
      event.start_date = 2.day.from_now
      event.end_date = 1.day.from_now

      expect(event.valid?).to be false
      expect(event).to have(1).errors_on(:start_date)
      expect(event).to have(1).errors_on(:end_date)
    end

    it 'validates that a event can not be saved if the associated resource not is available' do
      resource.switch_availability!

      expect(event.valid?).to be false
      expect(event).to have(1).errors
    end

    it 'validates that a event is not valid if there is an overlap with another event' do
      start_date = DateTime.now + 1.hours
      end_date = start_date + 2.hours

      event1 = Event.create(booking: booking, resource: resource, start_date: start_date, end_date: end_date)

      # Event that starts and ends at the same time than event1
      event2 = Event.create(booking: booking, resource: resource, start_date: start_date, end_date: end_date)
      expect(event2.valid?).to be false
      expect(event2).to have(1).errors

      # Event starting before and finishing after event1
      event3 = Event.create(booking: booking, resource: resource, start_date: start_date - 30.minutes, end_date: end_date + 30.minutes)
      expect(event3.valid?).to be false
      expect(event3).to have(1).errors

      # Event starting and finishing inside event1 range
      event4 = Event.create(booking: booking, resource: resource, start_date: start_date + 15.minutes, end_date: end_date - 15.minutes)
      expect(event4.valid?).to be false
      expect(event4).to have(1).errors

      # Event starting before and finishing inside event1
      event5 = Event.create(booking: booking, resource: resource, start_date: start_date - 30.minutes, end_date: start_date + 30.minutes)
      expect(event5.valid?).to be false
      expect(event5).to have(1).errors

      # Event starting inside event1 and finishing after
      event6 = Event.create(booking: booking, resource: resource, start_date: end_date - 30.minutes, end_date: end_date + 30.minutes)
      expect(event6.valid?).to be false
      expect(event6).to have(1).errors
    end
  end
end
