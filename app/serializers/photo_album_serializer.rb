class PhotoAlbumSerializer < ActiveModel::Serializer
  attributes :id

	has_many :square_photos
end
