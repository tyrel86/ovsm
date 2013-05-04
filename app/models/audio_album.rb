class AudioAlbum < ActiveRecord::Base
  attr_accessible :title
	
	has_many :audio_files
end
