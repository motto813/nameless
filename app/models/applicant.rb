require 'bcrypt'

class Applicant < ActiveRecord::Base
  has_many :resumes
  has_many :applications, { through: :resumes }

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true

  before_save :encrypt_password

  def encrypt_password
    self.password = BCrypt::Password.create(self.password)
  end
end
