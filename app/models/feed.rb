class Feed < ActiveRecord::Base
  attr_accessible :lat, :lng, :name, :slug, :time_zone
	attr_accessor :distance

	acts_as_mappable :default_units => :miles,
                   :default_formula => :sphere,
                   :distance_field_name => :distance,
                   :lat_column_name => :lat,
                   :lng_column_name => :lng


	has_many :feed_banners
	has_many :feed_videos
	has_many :users
	has_many :businesses
	before_save :update_slug
	before_create :initilize_dependancies, :update_time_zone
	has_one :forecast
	has_many :posts

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
		Time.strptime(current_time.strftime("%I:%M:%S"),"%I:%M:%S").to_i
	end

	def has_video?
		feed_videos.count > 0
	end

	def number_of_users
		users.count
	end

end
