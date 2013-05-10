class AudioAlbum < ActiveRecord::Base
  attr_accessible :title
	
	belongs_to :post	
	has_many :audio_files, dependent: :destroy
end
