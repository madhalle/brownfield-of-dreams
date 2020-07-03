class User < ApplicationRecord
  has_many :user_videos, dependent: :destroy
  has_many :videos, through: :user_videos

  validates :email, uniqueness: true, presence: true
  validates_presence_of :password
  validates_presence_of :first_name
  enum role: { default: 0, admin: 1 }
  has_secure_password

  def self.find_or_create_from_auth(auth)
    user = User.find_or_create_from_auth(provider: auth['provider'], uid: auth['uid'])
    require "pry"; binding.pry
    user.firstname = auth['info']['firstname']
    user.lastname = auth['info']['lastname']
    user.email = auth['info']['email']
    user.token = auth['credentials']['token']

    user.save
    user
  end
end
