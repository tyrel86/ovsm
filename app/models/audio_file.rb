class AudioFile < ActiveRecord::Base
	serialize :aws_urls, ActiveRecord::Coders::Hstore

  attr_accessible :aws_urls, :panda_id, :name
	attr_accessor :panda_id
	belongs_to :audio_album


	before_create :get_aws_urls_from_panda

	def get_aws_urls_from_panda
		return false unless panda_id
		panda = Panda::Video.find( panda_id )
		encodings = panda.encodings
		self.name = panda.original_filename.split(".").first
			["oga", "mp3"].each do |encoding|
				self.aws_urls[encoding.to_sym] = encodings[encoding].url
			end
	end

	def mp3_url
		aws_urls["mp3"]
	end

	def oga_url
		aws_urls["oga"]
	end

end
