class VideoAlbum < ActiveRecord::Base
  attr_accessible :title

	belongs_to :post	
	has_many :video_files, dependent: :destroy
end
