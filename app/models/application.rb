class Application < ActiveRecord::Base
  belongs_to :resume
  belongs_to :position
  belongs_to :interview

  validates :resume_id, presence: true
  validates :position_id, presence: true
  validates :interview_id, uniqueness: true, allow_nil: true

  def is_created_by_applicant?(applicant)
    self.resume.applicant == applicant
  end

  def self.submitted_by_applicant(applicant)
    self.where(resume: Resume.where(applicant: applicant))
  end

  def self.submitted_for_position(position)
    self.where(position: position)
  end

  def scheduled_for_interview?
    self.interview_id != nil
  end
end
