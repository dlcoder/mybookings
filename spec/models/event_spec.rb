require 'spec_helper'

describe Event do
  let(:event) { Event.new(start_date: 1.hour.from_now, end_date: 2.hour.from_now) }

  it 'validates that a event with start date in the past is not valid' do
    event.start_date = 2.hour.ago

    expect(event.valid?).to be_false
    expect(event).to have(1).errors_on(:start_date)
  end

  it 'validates that a event with end date in the past is not valid' do
    event.start_date = 2.hour.ago
    event.end_date = 1.hour.ago

    expect(event.valid?).to be_false
    expect(event).to have(1).errors_on(:end_date)
  end

  it 'validates that a event with start date greater than end date is not valid' do
    event.start_date = 2.day.from_now
    event.end_date = 1.day.from_now

    expect(event.valid?).to be_false
    expect(event).to have(1).errors_on(:start_date)
    expect(event).to have(1).errors_on(:end_date)
  end

end
