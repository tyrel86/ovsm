class AudioFile < ActiveRecord::Base

  attr_accessible :name, :file
	mount_uploader :file, AudioFileUploader
	belongs_to :audio_album

	before_save :default_name

	def default_name
		self.name = nil if name.empty?
    self.name ||= file.to_s.split("/").last.split(".").first
  end

end
