class LandscapePhoto < ActiveRecord::Base
  attr_accessible :caption, :photo

	mount_uploader :photo, LandscapePhotoUploader

	belongs_to :user
	belongs_to :photo_album
end
