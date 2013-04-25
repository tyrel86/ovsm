class FeedBanner < ActiveRecord::Base
  attr_accessible :feed_id, :image, :active
	belongs_to :feed
	mount_uploader :image, FeedBannerUploader
end
