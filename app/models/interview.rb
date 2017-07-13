class Interview < ActiveRecord::Base
  belongs_to :application
  belongs_to :applicant
  belongs_to :recruiter

  validates :application_id, presence: true, uniqueness: true
  validates :applicant_id, presence: true
  validates :recruiter_id, presence: true
end
