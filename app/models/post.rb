class Post < ActiveRecord::Base
  attr_accessible :content, :lat, :lng, :photo_ids, :audio_ids, :video_ids, :post_category_id,
									:has_video, :has_audio, :has_photos, :has_links
	attr_accessor :lat, :lng, :photo_ids, :audio_ids, :video_ids, :created_page_link_this_time
	belongs_to :feed
	belongs_to :user
	has_one :photo_album, dependent: :destroy
	has_one :audio_album, dependent: :destroy
	has_one :video_album, dependent: :destroy
	belongs_to :post_category
	has_and_belongs_to_many :page_links

	before_save :arayify_id_attrs, :initilize_dependancies, :consolidate_albums, :link_or_create_page_links_from_content,
							:convert_line_brakes, :sanatize_html, :update_has_attrs

	def link_or_create_page_links_from_content
		URI.extract(content, ['http', 'https']).each do |url|
			pl = PageLink.find_by_url( url )
			pl ||= PageLink.create( url: url )
			self.page_links << pl if pl.valid? and not self.page_links.include? pl
			self.created_page_link_this_time = true
		end
	end

	def convert_line_brakes
		self.content.gsub!("\n","<br>")
	end

	def sanatize_html
		self.content = Sanitize.clean(content, Sanitize::Config::RESTRICTED)
	end

	def update_has_attrs
		self.has_video = (video_album.video_files.size > 0) ? true : false
		self.has_audio = (audio_album.audio_files.size > 0) ? true : false
		self.has_photos = (photo_album.square_photos.size > 0) ? true : false
		self.has_links = (page_links.count > 0 or created_page_link_this_time) ? true : false
		true
	end

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
		self.build_photo_album unless photo_album
		self.build_audio_album unless audio_album
		self.build_video_album unless video_album
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

	def exerpt
		HTML_Truncator.truncate(content, 20)
	end

	scope :with_text, where{ content != "" }
	scope :with_photos, where{ has_photos == true }
	scope :with_links, where{ has_links == true }
	scope :with_audio, where{ has_audio == true }
	scope :with_video, where{ has_video == true }

end
