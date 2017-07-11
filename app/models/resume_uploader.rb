class ResumeUploader < CarrierWave::Uploader::Base
  storage :file
  def extension_whitelist
    %w( jpg jpeg gif png pdf doc docx txt odt )
  end
end
