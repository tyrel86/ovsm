class AudioAlbumSerializer < ActiveModel::Serializer
  attributes :id

	has_many :audio_files
end
