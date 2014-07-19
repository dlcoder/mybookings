class User < ActiveRecord::Base
  include Loggable

  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable,
         :omniauthable

  has_many :bookings
  has_and_belongs_to_many :resource_types, join_table: 'user_managed_resource_types'

  include RoleModel

  roles :admin, :manager

  def self.find_saml_user_or_create(auth)
    where(email: auth['info']['email']).first_or_create do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      user.email = auth['info']['email']
      user.password = Devise.friendly_token[0,20]
    end
  end

  def self.by_id
    order(id: :asc)
  end

end
