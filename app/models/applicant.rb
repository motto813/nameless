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

  def self.authenticate(email, password)
    applicant = self.find_by(email: email)
    unless applicant.nil?
      db_password = BCrypt::Password.new(applicant.password)
      return applicant if db_password == password
    end
    return nil
  end

  def self.authorized?(applicant, id)
    if applicant.instance_of?(self)
      applicant.id == id.to_i
    else
      false
    end
  end
end
