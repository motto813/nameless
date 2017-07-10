require 'carrierwave'
require 'carrierwave/orm/activerecord'

class ResumeUploader < CarrierWave::Uploader::Base
  storage :file
end
