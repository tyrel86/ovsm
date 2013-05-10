class PhotoAlbum < ActiveRecord::Base
  attr_accessible :title

	belongs_to :post	
	# has_many :landscape_photos, dependent: :destroy
	# has_many :portrait_photos, dependent: :destroy
	has_many :square_photos, dependent: :destroy
end
