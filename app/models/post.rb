class Post < ActiveRecord::Base
  attr_accessible :content, :lat, :lng, :photo_ids, :audio_ids, :video_ids, :post_category_id,
									:has_video, :has_audio, :has_photos, :has_links, :state,
									:promo_price, :promo_discounted_price, :promo_description, :promo_street_address, :promo_city,
									:promo_state, :promo_zip, :promo_start_date, :promo_end_date, :promo_labor_characteristic,
									:promo_free, :promo_wage, :promo_wage_time, :promo_shipping_cost, :promo_href, :promo_image, :promo_name,
									:location_type, :promo_contact_email, :promo_type
	attr_accessor :lat, :lng, :photo_ids, :audio_ids, :video_ids, :created_page_link_this_time, :location_type
	mount_uploader :promo_image, PromoImageUploader
	belongs_to :feed
	belongs_to :user
	belongs_to :business
	has_one :photo_album, dependent: :destroy
	has_one :audio_album, dependent: :destroy
	has_one :video_album, dependent: :destroy
	belongs_to :post_category
	has_many :panda_uploads
	has_and_belongs_to_many :page_links

	before_save :arayify_id_attrs, :initilize_dependancies, :update_photo_album, :create_panda_uploads, 
							:link_or_create_page_links_from_content,
							:convert_line_brakes, :sanatize_html, :update_has_attrs,
							:update_state, :decern_promo_loc

	def promo_address
		if promo_street_address or promo_city or promo_state or promo_zip
			"#{promo_street_address} #{promo_city}, #{promo_state} #{promo_zip}"
		else
			false
		end
	end

	def decern_promo_loc
		if location_type == "same"
			business = self.business
			self.promo_street_address = business.street_address
			self.promo_city = business.city
			self.promo_state = business.state
			self.promo_zip = business.zip_code
		elsif location_type == "none"
			self.promo_street_address = nil
			self.promo_city = nil
			self.promo_state = nil
			self.promo_zip = nil
		end
	end

	def update_state
		self.ready = panda_uploads.empty? ? true : false
		true
	end

	#Page Links
	def link_or_create_page_links_from_content
		if content
			URI.extract(content, ['http', 'https']).each do |url|
				pl = PageLink.find_by_url( url )
				pl ||= PageLink.create( url: url )
				self.page_links << pl if pl.valid? and not self.page_links.include? pl
				self.created_page_link_this_time = true if pl.valid?
			end
		end
	end

	def convert_line_brakes
		self.content.gsub!("\n","<br>") if content
	end

	def sanatize_html
		self.content = Sanitize.clean(content, Sanitize::Config::RESTRICTED) if content
	end

	#For easy fast content filter queries
	def update_has_attrs
		unless promotional == true
			self.has_video = (video_album.video_files.size > 0) ? true : false
			self.has_audio = (audio_album.audio_files.size > 0) ? true : false
			self.has_photos = (photo_album.square_photos.size > 0) ? true : false
			self.has_links = (page_links.count > 0 or created_page_link_this_time) ? true : false
		end
		true
	end

	# Transform all id attrs from "1,2,3,4" to [1,2,3,4] for array attrs comming from post update or create
	def arayify_id_attrs
		[:photo_ids, :audio_ids, :video_ids].each do |attr|
			value = send(attr)
			unless value.nil?
				val_array = value.split(",").inject([]) do |r,v|
					if attr == :photo_ids
						r << v.to_i
					else
						r << v
					end
				end
			end
			val_array ||= []
			self.send("#{attr}=", val_array)
		end
	end

	# Adds photos to photo album
	def update_photo_album
		photo_ids.each do |photo_id|
			photo = SquarePhoto.find( photo_id )
			self.photo_album.square_photos << photo
		end
	end

	# For each media id from post transform to panda upload and link to post
	def create_panda_uploads
		[:audio_ids, :video_ids].each do |media_attr|
			send(media_attr).each do |media_id|
				puts media_id
				panda_upload = PandaUpload.create( panda_id: media_id, media_type: media_attr.to_s[0..4] )
				self.panda_uploads << panda_upload
			end
		end
	end

	#Insure required child relationships
	def initilize_dependancies
		self.build_photo_album unless photo_album
		self.build_audio_album unless audio_album
		self.build_video_album unless video_album
	end

	#View Helpers
	def exerpt
		HTML_Truncator.truncate(content, 20)
	end

	#Scopes
	scope :with_text, where{ content != "" }
	scope :with_photos, where{ has_photos == true }
	scope :with_links, where{ has_links == true }
	scope :with_audio, where{ has_audio == true }
	scope :with_video, where{ has_video == true }

end
