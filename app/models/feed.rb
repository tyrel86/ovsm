class Feed < ActiveRecord::Base
  attr_accessible :lat, :lng, :name, :slug
	has_many :feed_banners
	before_save :update_slug
	before_create :initilize_dependancies
	has_one :forecast

	def initilize_dependancies
		self.build_forecast
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
end
