module Mybookings
  class User < ActiveRecord::Base
    include ::RoleModel
    include Loggable

    devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable, :omniauthable
    devise :registerable if MYBOOKINGS_CONFIG['devise_registerable']

    has_many :bookings
    has_and_belongs_to_many :resource_types, join_table: 'mybookings_user_managed_resource_types'

    roles [:admin, :manager] + MYBOOKINGS_CONFIG['extra_roles']

    def self.find_saml_user_or_create(auth)
      user = where(email: auth['info']['email']).first_or_create do |user|
        user.provider = auth['provider']
        user.uid = auth['uid']
        user.email = auth['info']['email']
        user.password = Devise.friendly_token[0,20]
      end

      user.assign_roles auth

      user
    end

    def self.by_id
      order(id: :asc)
    end

    def assign_roles auth; end

    def get_all_posibles_masks_for_roles
      masks = Array.new

      roles.each do |role|
        masks = masks + get_masks_from_role(role)
      end

      masks.uniq.sort
    end

    private

    def get_masks_from_role(role)
      role_index = self.class.valid_roles.index(role)
      masks = Array.new

      i = 0
      while i < 2**self.class.valid_roles.length
        bit_position = 2**role_index
        smallest_range_value = i + bit_position
        largest_range_value = (i + (bit_position * 2)) - 1
        masks.concat((smallest_range_value..largest_range_value).to_a)
        i += bit_position * 2
      end

      masks
    end
  end
end
