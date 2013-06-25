class UsersController < ApplicationController
	def index
		redirect_to "/users/#{current_user.username}"
	end
	def show
		@user = User.find_by_username( params[:id] )
		@feed = @user.feed
		@forecast = @feed.forecast
		@post_categories = PostCategory.all
	end
end
