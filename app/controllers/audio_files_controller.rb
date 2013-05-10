class AudioFilesController < ApplicationController
	def create
		@audio_file = AudioFile.create( params[:audio_file] )
		respond_to do |format|
			format.js
		end
	end
end
