class Booking < ActiveRecord::Base
  include Loggable

  belongs_to :user
  belongs_to :resource_type
  has_many :events , inverse_of: :booking

  accepts_nested_attributes_for :events

  enum status: %w(pending occurring expired)

  delegate :email, to: :user, prefix: true

  def self.by_start_date
    includes(:events).order('events.start_date DESC')
  end

  def self.new_for_user user, params
    booking = Booking.new(params)
    booking.user = user

    booking
  end

  def self.about_to_begin
    Booking.pending.where('? >= start_date', Time.now + MYBOOKINGS_CONFIG['extensions_trigger_frequency'].minutes)
  end

  def self.recently_finished
    Booking.occurring.where('? >= end_date', Time.now)
  end

end
