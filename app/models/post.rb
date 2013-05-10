class Post < ActiveRecord::Base
  attr_accessible :content, :lat, :lng, :photo_ids, :audio_ids, :video_ids
	attr_accessor :lat, :lng, :photo_ids, :audio_ids, :video_ids
	belongs_to :feed
	belongs_to :user
	has_one :photo_album, dependent: :destroy
	has_one :audio_album, dependent: :destroy
	has_one :video_album, dependent: :destroy
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
		self.build_photo_album unless photo_ids.nil? or photo_ids.empty?
		self.build_audio_album unless audio_ids.nil? or audio_ids.empty?
		self.build_video_album unless video_ids.nil? or video_ids.empty?
	end

	def consolidate_albums
		{photo: "SquarePhoto", audio: "AudioFile", video: "VideoFile"}.each do |attr, class_name|
			id_array = send("#{attr}_ids")
			album = send("#{attr}_album")
			id_array.each do |id|
				object = (eval class_name).find(id)
				instance_message = class_name.to_underscore.pluralize
				album.send(instance_message).send(:push, object)
			end
		end		
	end
end
