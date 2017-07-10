require 'carrierwave'
require 'carrierwave/orm/activerecord'

require_relative '../uploaders/resume_uploader'

class Resume < ActiveRecord::Base
  belongs_to :applicant

  has_many :applications

  validates :file_name, presence: true
  validates :applicant_id, presence: true

  mount_uploader :resume_file, ResumeUploader
end
