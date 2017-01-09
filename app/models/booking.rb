class Booking < ActiveRecord::Base
  include Loggable

  belongs_to :user
  belongs_to :resource_type
  has_many :events , inverse_of: :booking

  accepts_nested_attributes_for :events

  delegate :email, to: :user, prefix: true
  delegate :name, to: :resource_type, prefix: true
  delegate :extension, to: :resource_type, prefix: true
  delegate :users, to: :resource_type, prefix: true

  def self.by_start_date
    includes(:events, :resource_type).order('resource_types.name ASC').group_by(&:resource_type)
  end

  def self.new_for_user user, params
    booking = Booking.new(params)
    booking.user = user

    booking
  end

  def delete_pending_events
    events.each do |event|
      event.destroy! if event.pending?
    end
  end

  def has_pending_events?
    events.pending.count > 0
  end

  def has_events?
    events.any?
  end

end
