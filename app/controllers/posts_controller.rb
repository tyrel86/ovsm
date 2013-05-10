class PostsController < ApplicationController
	def index
		@posts = Post.where( feed_id: params[:feed] ).where( promotional: params[:promotional] )
		@posts = Post.where( post_category_id: params[:category] ) if params[:category]
		respond_to do |format|
			format.json { render json: @posts }
		end
	end

  def new
		@post = Post.new
  end

  def create
		@post = Post.new( params[:post] )
		@post.user = current_user
		#Later will need to check for current_business and if it exists set to true
		@post.promotional = false
		latlng = [params[:post][:lat], params[:post][:lng]]
		latlng = fall_back_lat_lng_from_ip if latlng.first.nil? or latlng.last.nil? or latlng.first.empty? or latlng.last.empty?
		unless latlng.first.nil? or latlng.last.nil?
			@post.feed = Feed.closest( origin: latlng ).first
		else
			#Default to user profile home town for now denver soon based on user settings
			@post.feed = Feed.find_by_name( "Denver, CO" )
		end
		if @post.save
			redirect_to feed_path( Feed.first ), notice: "Post created"
		else
			redirect_to feed_path( Feed.first ), notice: "Error while tyring to create post"
		end
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
