class VideoFile < ActiveRecord::Base
	serialize :aws_urls, ActiveRecord::Coders::Hstore
  attr_accessible :aws_urls, :panda_id
	attr_accessor :panda_id
	belongs_to :video_album

	before_create :get_aws_urls_from_panda

	def get_aws_urls_from_panda
		return false unless panda_id
		encodings = Panda::Video.find( panda_id ).encodings
			["h264", "ogg", "webm"].each do |encoding|
				self.aws_urls[encoding.to_sym] = encodings[encoding].url
			end
	end

	def webm_url
		aws_urls["webm"]
	end

	def mp4_url
		aws_urls["h264"]
	end

	def ogv_url
		aws_urls["ogg"]
	end
end
