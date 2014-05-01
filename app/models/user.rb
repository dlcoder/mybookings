class User < ActiveRecord::Base
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable,
         :omniauthable

  has_many :bookings

  def self.find_saml_user_or_create(auth)
    where(email: auth['info']['email']).first_or_create do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      user.email = auth['info']['email']
      user.password = Devise.friendly_token[0,20]
    end
  end

end
