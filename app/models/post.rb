class Post < ActiveRecord::Base
  attr_accessible :content
	belongs_to :feed
	belongs_to :user
	has_one :photo_album
	has_one :audio_album
	has_one :video_album
end
