class User < ActiveRecord::Base
  #mass assignable atrributes
  attr_accessible :email, :name, :password, :password_confirmation, :checkedout_count, :remember_token, :password_digest 
  
  has_many :comments
  has_many :checkedouts
  has_many :books, :through => :checkedouts
  
  has_secure_password
  
  before_save { |user| user.email = email.downcase}
  before_save :create_remember_token

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, presence: true
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX}, 
  uniqueness: {case_sensitive: false}
  validates :password, presence: true, length:{minimum: 6}
  validates :password_confirmation, presence: true

  private
    def create_remember_token
   		self.remember_token = SecureRandom.urlsafe_base64
   	end

end
