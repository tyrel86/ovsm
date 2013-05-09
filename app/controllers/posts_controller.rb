class PostsController < ApplicationController
  def new
		@post = Post.new
  end

  def create
		@post = Post.new( params[:post] )
		if @post.save
			redirect_to feed_path( Feed.first ), notice: "Post created"
		else
			redirect_to feed_path( Feed.first ), notice: "Error while tyring to creat post"
		end
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
