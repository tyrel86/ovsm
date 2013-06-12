class SquarePhotosController < ApplicationController
	def create
		@square_photo = SquarePhoto.create( params[:square_photo] )
		@square_photo.user = current_user
		@square_photo.save
		respond_to do |format|
			format.js
		end
	end
end
