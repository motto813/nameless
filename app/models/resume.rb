class Resume < ActiveRecord::Base
  belongs_to :applicant

  has_many :applications

  validates :file_name, presence: true
  validates :applicant_id, presence: true

  mount_uploader :resume_file, ResumeUploader

  def self.uploaded_by_applicant(applicant)
    self.where(applicant: applicant)
  end
end
