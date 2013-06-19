class PageLink < ActiveRecord::Base
  attr_accessible :url, :description, :image_url, :title

	has_and_belongs_to_many :posts

	validate :fetch_data

	def fetch_data
		begin
			unless title and description and image_url
				object = LinkThumbnailer.generate( url )
				self.title = object.title
				self.description = object.description
				self.image_url = object.images.first.source_url.to_s
			end
			unless self.title and self.description and self.image_url
				self.errors[:url] << "Could not get content from url"
			else
				true
			end
		rescue
			self.errors[:url] << "Could not connect with #{url}"
			false
		end
	end

	def exerpt
		HTML_Truncator.truncate(description, 20)
	end

end
