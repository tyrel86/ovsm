class VideoFilesController < ApplicationController
	def create
		@video_file = VideoFile.create( params[:video_file] )
		respond_to do |format|
			format.js
		end
	end
end
