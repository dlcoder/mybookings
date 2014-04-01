class Booking < ActiveRecord::Base
  belongs_to :user
  belongs_to :resource

  validates_presence_of :resource
end
