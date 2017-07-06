class Position < ActiveRecord::Base
  belongs_to :company
  belongs_to :recruiter

  has_many :applications

  validates :title, presence: true
  validates :company_id, presence: true
  validates :recruiter_id, presence: true
end
