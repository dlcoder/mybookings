class Booking < ActiveRecord::Base
  include Loggable

  belongs_to :user
  belongs_to :resource

  enum status: %w(pending occurring expired)

  validates :resource, :start_date, :end_date, presence: true
  validate :dates_range
  validate :dates_in_the_future, :dates_overlap, on: :create

  delegate :email, to: :user, prefix: true
  delegate :name, to: :resource, prefix: true
  delegate :resource_type_name, to: :resource, prefix: true
  delegate :resource_type_extension, to: :resource, prefix: true

  def self.by_start_date
    order(start_date: :desc)
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

  private

  def dates_in_the_future
    unless start_date.nil?
      errors.add(:start_date, I18n.t('errors.messages.booking.start_date_in_the_past')) if start_date.past?
    end

    unless end_date.nil?
      errors.add(:end_date, I18n.t('errors.messages.booking.end_date_in_the_past')) if end_date.past?
    end
  end

  def dates_range
    unless start_date.nil? or end_date.nil?
      if end_date <= start_date
        errors.add(:start_date, I18n.t('errors.messages.booking.start_date_greater_than_end_date'))
        errors.add(:end_date, I18n.t('errors.messages.booking.end_date_smaller_than_start_date'))
      end
    end
  end

  def dates_overlap
    start_date = self.start_date - MYBOOKINGS_CONFIG['extensions_trigger_frequency'].minutes
    end_date = self.end_date + MYBOOKINGS_CONFIG['extensions_trigger_frequency'].minutes

    unless resource.nil?
      overlapped_bookings = resource.bookings.where('(? >= start_date AND ? <= end_date) OR (? >= start_date AND ? <= end_date)', start_date, start_date, end_date, end_date)
      errors.add(:base, I18n.t('errors.messages.booking.overlap')) if overlapped_bookings.any?
    end
  end
end
