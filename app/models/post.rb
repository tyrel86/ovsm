class Post < ActiveRecord::Base
  attr_accessible :content, :lat, :lng, :photo_ids, :audio_ids, :video_ids, :post_category_id
	attr_accessor :lat, :lng, :photo_ids, :audio_ids, :video_ids
	belongs_to :feed
	belongs_to :user
	has_one :photo_album, dependent: :destroy
	has_one :audio_album, dependent: :destroy
	has_one :video_album, dependent: :destroy
	belongs_to :post_category
	has_many :page_links, dependent: :destroy

	before_save :arayify_id_attrs, :initilize_dependancies, :consolidate_albums

	# Transform all id attrs from "1,2,3,4" to [1,2,3,4]
	def arayify_id_attrs
		[:photo_ids, :audio_ids, :video_ids].each do |attr|
			value = send(attr)
			unless value.nil?
				val_array = value.split(",").inject([]) do |r,v|
					r << v.to_i
				end
			end
			self.send("#{attr}=", val_array)
		end
	end
	# End result could be nil or []

	def initilize_dependancies
		self.build_photo_album
		self.build_audio_album
		self.build_video_album
	end

	def consolidate_albums
		{photo: "SquarePhoto", audio: "AudioFile", video: "VideoFile"}.each do |attr, class_name|
			id_array = send("#{attr}_ids") || []
			album = send("#{attr}_album")
			id_array.each do |id|
				object = (eval class_name).find(id)
				instance_message = class_name.to_underscore.pluralize
				album.send(instance_message).send(:push, object)
			end
		end		
	end

	scope :with_photos, joins( :photo_album.outer )
	scope :has_photos, with_photos.where('posts.photo_album is not NULL')
	scope :has_audio, where('posts.audio_album_id is not NULL')
	scope :has_video, where('posts.video_album_id is not NULL')
end
