class Resume < ActiveRecord::Base
  belongs_to :applicant

  has_many :applications

  validates :file_location, presence: true
  validates :applicant_id, presence: true
end
