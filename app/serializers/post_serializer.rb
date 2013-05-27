class PostSerializer < ActiveModel::Serializer
  attributes :content, :exerpt, :created_at, :updated_at, :id

	has_one :user
	has_one :photo_album
	has_one :audio_album
	has_one :video_album
	has_many :page_links
end
