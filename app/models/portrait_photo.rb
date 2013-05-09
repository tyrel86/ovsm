class PortraitPhoto < ActiveRecord::Base
  attr_accessible :caption, :photo

	mount_uploader :photo, PortraitPhotoUploader
	belongs_to :user
	belongs_to :photo_album
end
