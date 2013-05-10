class VideoFile < ActiveRecord::Base
  attr_accessible :name, :file
	mount_uploader :file, VideoFileUploader

	belongs_to :video_album
	before_save :default_name

	def default_name
    self.name ||= File.basename(file.filename, '.*').titleize if file
  end
end
