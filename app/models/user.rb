class User < ActiveRecord::Base
  has_many :posts
  has_secure_password

  validates_presence_of     :name
  validates_presence_of     :password, allow_blank: true
  validates_presence_of     :password_confirmation
  validates_confirmation_of :password
end
