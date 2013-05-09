class SquarePhotosController < ApplicationController
	def create
		@square_photo = SquarePhoto.create( params[:square_photo] )
		respond_to do |format|
			format.js
		end
	end
end
