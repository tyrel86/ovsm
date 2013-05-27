class FeedVideosController < ApplicationController
	def show
		@video = FeedVideo.for_feed( Feed.find_by_slug( params[:feed_id] ) ).first
	end
end
