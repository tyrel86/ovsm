class AudioFileUploader < CarrierWave::Uploader::Base
	include CarrierWave::ZenCoder::Audio
	include CarrierWave::ZenCoder::UrlHelpers
	include Rails.application.routes.url_helpers
  Rails.application.routes.default_url_options = ActionMailer::Base.default_url_options

	after :store, :zencode
  storage :fog

	def extension_white_list
    %w(mp3 aac ogg wma wav ra ram rm)
  end

  def store_dir
    "uploads/#{Rails.env}/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

end
