class FeedVideo < ActiveRecord::Base
  attr_accessible :active, :feed_id, :video
	belongs_to :feed
	mount_uploader :video, FeedVideoUploader

	scope :active, where( active: true )
	scope :for_feed, lambda { |feed| where( feed_id: feed.id ).active }

	def self.url_for( feed, encoding )
		"https://overseame.s3.amazonaws.com/uploads/#{Rails.env}/feed_video/#{feed.slug}/current.#{encoding}"
	end
end
