class FeedsController < ApplicationController

	def index
		respond_to do |format|
			format.html { render layout: "full_content_span" }
			format.json do
				@feeds = Feed.all
				render json: @feeds
			end
		end
	end

	#From the airplane form in the feeds index
	def fly_and_show
		@feed = Feed.find_by_name( params[:feed][:name] )
		redirect_to @feed
	end

	def show
		@feed = Feed.find_by_slug( params[:id] )
		@forecast = @feed.forecast
	end

end
