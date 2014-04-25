class Booking < ActiveRecord::Base
  belongs_to :user
  belongs_to :resource

  validates :resource, :start_date, :end_date, presence: true
  validate :resource_exists
  validate :date_in_the_future
  validate :date_range

  delegate :name, to: :resource, prefix: true

  def self.for_user user
    where(user_id: user.id)
  end

  def self.create_for_user user, params
    booking = Booking.new(params)
    booking.user = user

    booking.save

    booking
  end

  private

  def resource_exists
    errors.add(:resource_id, I18n.t('errors.messages.blank')) if resource.nil?
  end

  def date_in_the_future
    unless start_date.nil?
      errors.add(:start_date, I18n.t('errors.messages.booking.start_date_in_the_past')) if start_date.past?
    end

    unless end_date.nil?
      errors.add(:end_date, I18n.t('errors.messages.booking.end_date_in_the_past')) if end_date.past?
    end
  end

  def date_range
    unless start_date.nil? or end_date.nil?
      if end_date <= start_date
        errors.add(:start_date, I18n.t('errors.messages.booking.start_date_greater_than_end_date'))
        errors.add(:end_date, I18n.t('errors.messages.booking.end_date_smaller_than_start_date'))
      end
    end
  end
end
