require 'bcrypt'

class Recruiter < ActiveRecord::Base
  has_many :positions
  has_many :interviews

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true

  validates :password, presence: true, confirmation: true
  validates :password_confirmation, presence: true

  before_save :encrypt_password

  def encrypt_password
    self.password = BCrypt::Password.create(self.password)
  end

  def self.authenticate(email, password)
    recruiter = self.find_by(email: email)
    unless recruiter.nil?
      db_password = BCrypt::Password.new(recruiter.password)
      return recruiter if db_password == password
    end
    return nil
  end

  def self.authorized?(recruiter, recruiter_id)
    if recruiter.instance_of?(self)
      recruiter.id == recruiter_id.to_i
    else
      false
    end
  end

  def full_name
    "#{self.first_name} #{self.last_name}"
  end
end
