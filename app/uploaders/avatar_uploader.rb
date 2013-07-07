# encoding: utf-8

class AvatarUploader < CarrierWave::Uploader::Base

  include CarrierWave::RMagick
  storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{Rails.env}/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

	def default_url
		"/assets/defaults/avatar#{version_name ? '_' + version_name.to_s : ''}.png"
  end

	process :resize_to_limit => [400, 0]

  version :thumb do
    process :resize_to_fill => [75,75]
  end


end
