class PostsController < ApplicationController
	before_filter :require_login

	def index
		if params[:user]
			unless params[:luggage] == "true"
				@posts = Post.where( user_id: params[:user] ).where( promotional: params[:promotional] ).where( ready: true ).order("created_at desc")
			else
				@user = User.find( params[:user] )
				@posts = Post.where( id: @user.suit_case_post_ids )
			end
		elsif params[:feed]
			@posts = Post.where( feed_id: params[:feed] ).where( promotional: params[:promotional] ).where( ready: true ).order("created_at desc")
		else
			@posts = Post.where( promotional: params[:promotional] ).where( ready: true ).order("created_at desc")
		end
		@posts = @posts.where( post_category_id: params[:category] ) if params[:category]
		@posts = @posts.send( "with_#{params[:content_type]}" ) if params[:content_type]
		Time.parse(params[:last_post_time]) if params[:last_post_time]
		last_post_time = params[:last_post_time] || Time.now + 1.second
		@posts = @posts.where{ created_at < last_post_time } if params[:last_post_time]
		@posts = @posts.limit( 20 )
		
		params[:page] ||= 1
		respond_to do |format|
			format.json { render json: @posts }
		end
	end

  def new
		@post = Post.new
		render "new_promo" if business_signed_in?
  end

  def create
		@post = Post.new( params[:post] )
		if user_signed_in?
			@post.user = current_user
			@post.promotional = false
			latlng = [params[:post][:lat], params[:post][:lng]]
			latlng = fall_back_lat_lng_from_ip if latlng.first.nil? or latlng.last.nil? or latlng.first.empty? or latlng.last.empty?
			unless latlng.first.nil? or latlng.last.nil?
				@post.feed = Feed.closest( origin: latlng ).first
			else
				#Default to user profile home town for now denver soon based on user settings
				@post.feed = Feed.find_by_name( "Denver, CO" )
			end
		elsif business_signed_in?
			@post.business = current_business
			@post.promotional = true
			@post.feed = current_business.feed
		end
		if @post.save
			redirect_to feed_path( @post.feed ), notice: "Post created"
		else
			redirect_to feed_path( @post.feed ), notice: "Error while tyring to create post"
		end
  end

	def show
		@post = Post.find( params[:id] )
	end

  def edit
  end

  def update
  end

  def destroy
  end

end
