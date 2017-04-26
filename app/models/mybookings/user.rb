module Mybookings
  class User < ActiveRecord::Base
    include ::RoleModel
    include Loggable

    acts_as_paranoid

    devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable, :omniauthable
    devise :registerable if MYBOOKINGS_CONFIG['devise_registerable']

    has_many :bookings
    has_and_belongs_to_many :resource_types, join_table: 'mybookings_user_managed_resource_types'

    validates :first_name, :last_name, length: { maximum: 50 }

    roles [:admin, :manager] + MYBOOKINGS_CONFIG['extra_roles']

    def self.find_saml_user_or_create(auth)
      email = self::email_address_from_auth(auth)

      user = where(email: email).first_or_create do |user|
        user.provider = auth['provider']
        user.uid = auth['uid']
        user.email = email
        user.password = Devise.friendly_token[0,20]
      end

      user.hook_post_find_saml_user_or_create(auth)

      user
    end

    def self.email_address_from_auth auth
      auth['info']['email']
    end

    def self.by_id
      order(id: :asc)
    end

    def self.search search_string
      where("email like ?", "%#{search_string}%")
    end

    def hook_post_find_saml_user_or_create auth; end

    def get_all_posibles_masks_for_roles
      masks = Array.new

      roles.each do |role|
        masks = masks + get_masks_from_role(role)
      end

      masks.uniq.sort
    end

    def can_booking_resource_type? resource_type
      return true if !resource_type.has_roles?

      possible_masks = get_all_posibles_masks_for_roles

      possible_masks.each do |e|
        return true if e == resource_type.roles_mask
      end

      return false
    end

    private

    def get_masks_from_role(role)
      role_index = self.class.valid_roles.index(role)
      masks = Array.new
      bit_position = 2**role_index

      i = 0
      while i < 2**self.class.valid_roles.length
        smallest_range_value = i + bit_position
        largest_range_value = (i + (bit_position * 2)) - 1
        masks.concat((smallest_range_value..largest_range_value).to_a)
        i += bit_position * 2
      end

      masks
    end
  end
end
