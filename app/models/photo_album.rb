class PhotoAlbum < ActiveRecord::Base
  attr_accessible :title
	
	has_many :landscape_photos
	has_many :portrait_photos
	has_many :square_photos
end
