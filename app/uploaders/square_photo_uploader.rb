# encoding: utf-8

class SquarePhotoUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick
  storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{Rails.env}/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

	def extension_white_list
    %w(jpg jpeg gif png)
  end

  version :thumb do
    process :resize_to_fill => [230,230]
  end

  version :large do
    process :resize_to_fill => [690,690]
  end
end
