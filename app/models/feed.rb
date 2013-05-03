class Feed < ActiveRecord::Base
  attr_accessible :lat, :lng, :name, :slug, :time_zone
	has_many :feed_banners
	before_save :update_slug
	before_create :initilize_dependancies, :update_time_Zone
	has_one :forecast

	def initilize_dependancies
		self.build_forecast
	end

	def update_time_zone
		timezone = Timezone::Zone.new :latlon => [lat, lng]
		self.time_zone = timezone.zone
	end

	def to_param
		slug
	end

	def update_slug
		self.slug = name.parameterize
	end	

	def banner( thumb = false )
		image = feed_banners.where( active: true ).first.image
		thumb ? image.thumb : image
	end

	def current_time
		Time.current.in_time_zone time_zone
	end

	def current_time_stamp
		current_time.to_i
	end
end
