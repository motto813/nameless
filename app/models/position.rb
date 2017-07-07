class Position < ActiveRecord::Base
  belongs_to :company
  belongs_to :recruiter

  has_many :applications

  validates :title, presence: true
  validates :description, presence: true
  validates :company_id, presence: true
  validates :recruiter_id, presence: true

  def is_applied_to_by_applicant?(applicant)
    self.applications.each do |application|
      return true if application.resume.applicant == applicant
    end
    return false
  end

  def was_created_by_recruiter?(recruiter)
    self.recruiter == recruiter
  end
end
