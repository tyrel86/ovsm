class PageLink < ActiveRecord::Base
  attr_accessible :url, :description, :image_url, :title

	belongs_to :post

	before_create :fetch_data

	def fetch_data
		object = LinkThumbnailer.generate( url )
		self.title = object.title
		self.description = object.description
		self.image_url = object.images.first.source_url
	end
end
