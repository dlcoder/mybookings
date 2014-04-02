class Booking < ActiveRecord::Base
  belongs_to :user
  belongs_to :resource

  validates :resource, :start_date, :end_date, presence: true
  validate :resource_exists

  private

  def resource_exists
    errors.add(:resource_id, I18n.t('errors.messages.blank')) if resource.nil?
  end
end
