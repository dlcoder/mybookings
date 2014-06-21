class ResourceType < ActiveRecord::Base
  has_many :resources

  validates :name, presence: true

  def resources_number
    self.resources.count
  end
end
