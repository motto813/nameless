class Interview < ActiveRecord::Base
  belongs_to :application
  belongs_to :applicant
  belongs_to :recruiter

  validates :application_id, presence: true, uniqueness: true
  validates :applicant_id, presence: true
  validates :recruiter_id, presence: true

  def self.have_a_common_interview?(applicant_id, recruiter_id)
    !self.find_by(applicant_id: applicant_id, recruiter_id: recruiter_id).nil?
  end
end
