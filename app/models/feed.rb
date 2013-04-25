class Feed < ActiveRecord::Base
  attr_accessible :lat, :lng, :name, :id_for_weather_api, :slug
	has_many :feed_banners
	before_save :update_slug

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
