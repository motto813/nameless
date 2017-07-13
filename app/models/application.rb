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

  def self.submitted_by_applicant(applicant_id)
    self.where(resume: Resume.where(applicant_id: applicant_id))
  end

  def self.submitted_for_position(position_id)
    self.where(position_id: position_id)
  end

  def scheduled_for_interview?
    self.interview_id != nil
  end
end
