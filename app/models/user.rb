class User < ActiveRecord::Base
  has_many :posts
  has_secure_password

  validates_presence_of     :name
  validates_presence_of     :password, allow_blank: true
  validates_presence_of     :password_confirmation
  validates_confirmation_of :password
  
  before_create :create_remember_token
  
  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end
  
  private

  def create_remember_token
    self.remember_token = User.encrypt(User.new_remember_token)
  end
  
end
