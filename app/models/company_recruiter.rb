class CompanyRecruiter < ActiveRecord::Base
  belongs_to :company
  belongs_to :recruiter

  validates :company_id, presence: true
  validates :recrutier_id, presence: true
end
