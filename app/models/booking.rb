class Booking < ActiveRecord::Base
  include Loggable

  belongs_to :user
  belongs_to :resource_type
  has_many :events , inverse_of: :booking

  accepts_nested_attributes_for :events

  delegate :email, to: :user, prefix: true
  delegate :name, to: :resource_type, prefix: true

  def self.by_start_date
    includes(:events).order('events.start_date DESC')
  end

  def self.new_for_user user, params
    booking = Booking.new(params)
    booking.user = user

    booking
  end

end
