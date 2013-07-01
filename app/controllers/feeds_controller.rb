class FeedsController < ApplicationController
	before_filter :require_login

	def index
		respond_to do |format|
			format.html { render layout: "full_content_span" }
			format.json do
				@feeds = Feed.all
				render json: @feeds
			end
		end
	end

	def business_root
		redirect_to current_business.feed if current_business
		redirect_to new_business_session_path unless current_business
	end

	def fly_and_show
		@feed = Feed.find_by_name( params[:feed][:name] )
		redirect_to @feed
	end

	def show
		@feed = Feed.find_by_slug( params[:id] )
		@forecast = @feed.forecast
		@post_categories = PostCategory.all
	end

end
