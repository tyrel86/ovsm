class PageLink < ActiveRecord::Base
  attr_accessible :url, :description, :image_url, :title

	has_and_belongs_to_many :posts

	validate :fetch_data

	def fetch_data
		begin
			object = LinkThumbnailer.generate( url )
			self.title = object.title
			self.description = object.description
			self.image_url = object.images.first.source_url.to_s
		rescue
			self.errors[:url] << "Could not connect with #{url}"
			return false
		end
	end

end
