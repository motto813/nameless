require 'bcrypt'

class Recruiter < ActiveRecord::Base
  has_many :positions

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true

  before_save :encrypt_password

  def encrypt_password
    self.password = BCrypt::Password.create(self.password)
  end
end
