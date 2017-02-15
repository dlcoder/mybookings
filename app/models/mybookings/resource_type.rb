module Mybookings
  class ResourceType < ActiveRecord::Base
    include ::RoleModel
    include Loggable

    acts_as_paranoid

    has_one :booking
    has_many :resources, dependent: :destroy
    has_and_belongs_to_many :users, join_table: 'mybookings_user_managed_resource_types'

    validates :name, :extension, presence: true

    roles [:admin, :manager] + MYBOOKINGS_CONFIG['extra_roles']

    def self.by_name
      order(name: :asc)
    end

    def resources_number
      self.resources.count
    end

    def managed_by? user
      self.users.exists? user.id
    end

    def can_create? user
      return true if roles_mask == 0

      possible_masks = user.get_all_posibles_masks_for_roles

      possible_masks.each do |e|
        return true if e == roles_mask
      end

      return false
    end
  end
end
