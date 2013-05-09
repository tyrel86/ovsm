class SquarePhoto < ActiveRecord::Base
  attr_accessible :caption, :photo

	mount_uploader :photo, SquarePhotoUploader
	belongs_to :user
	belongs_to :photo_album

end
