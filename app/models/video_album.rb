class VideoAlbum < ActiveRecord::Base
  attr_accessible :title

	has_many :video_files
end
