class Booking < ActiveRecord::Base
  belongs_to :user
  belongs_to :resource

  validates :resource, :start_date, :end_date, presence: true
  validate :resource_exists

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
end
