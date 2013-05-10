class AudioFile < ActiveRecord::Base

  attr_accessible :name, :file
	mount_uploader :file, AudioFileUploader
	belongs_to :audio_album

	before_save :default_name

	def default_name
    self.name ||= File.basename(file.filename, '.*').titleize if file
  end

end
