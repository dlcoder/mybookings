class Booking < ActiveRecord::Base
  belongs_to :user
  belongs_to :resource

  validates :resource, :start_date, :end_date, presence: true
  validate :dates_range
  validate :dates_in_the_future, :dates_overlap, on: :create

  delegate :email, to: :user, prefix: true
  delegate :name, to: :resource, prefix: true
  delegate :resource_type_name, to: :resource, prefix: true

  def self.by_start_date
    order(start_date: :desc)
  end

  def self.create_for_user user, params
    booking = Booking.new(params)
    booking.user = user

    booking.save

    booking
  end

  def self.expired_bookings
    where('? > end_date', Time.now)
  end

  def self.pending_bookings
    where('? < start_date', Time.now)
  end

  def self.occurring_bookings
    where('? >= start_date AND ? <= end_date', Time.now, Time.now)
  end

  # TODO: Think about moving that methods to a presenter
  # http://railscasts.com/episodes/286-draper
  def pending?
    self.start_date.future?
  end

  def expired?
    self.end_date.past?
  end

  def occurring?
    self.start_date.past? && self.end_date.future?
  end

  def has_feedback?
    !self.feedback.nil?
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
    unless resource.nil?
      overlapped_bookings = resource.bookings.where('(? >= start_date AND ? <= end_date) OR (? >= start_date AND ? <= end_date)', start_date, start_date, end_date, end_date)
      errors.add(:base, I18n.t('errors.messages.booking.overlap')) if overlapped_bookings.any?
    end
  end

end
