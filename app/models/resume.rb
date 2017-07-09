require 'carrierwave'
require 'carrierwave/orm/activerecord'

class Resume < ActiveRecord::Base
  belongs_to :applicant

  has_many :applications

  validates :file_name, presence: true
  validates :applicant_id, presence: true

  before_save :create_file_path

  mount_uploader :resume_file,  ResumeUploader

  def create_file_path
    directory = "~/Documents/"
    self.file_path = directory + file_name
  end
end
