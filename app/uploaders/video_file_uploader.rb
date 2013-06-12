# encoding: utf-8

class VideoFileUploader < CarrierWave::Uploader::Base
	include CarrierWave::ZenCoder::UrlHelpers
	include CarrierWave::ZenCoder::Video
	include Rails.application.routes.url_helpers
  Rails.application.routes.default_url_options = ActionMailer::Base.default_url_options

	after :store, :zencode
  storage :fog

  def store_dir
    "uploads/#{Rails.env}/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
end
