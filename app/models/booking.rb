class Booking < ActiveRecord::Base
  belongs_to :user
  belongs_to :resource

  validates :resource, presence: true
end
