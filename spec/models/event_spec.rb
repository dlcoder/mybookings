require 'spec_helper'

describe Event do
  let(:resource) { Resource.new(name: 'Resource', resource_type: ResourceType.new ) }
  let(:event) { Event.new(resource: resource, start_date: 1.hour.from_now, end_date: 2.hour.from_now) }

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

end
