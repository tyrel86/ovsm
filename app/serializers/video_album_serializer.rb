class VideoAlbumSerializer < ActiveModel::Serializer
  attributes :id
	
	has_many :video_files
end
