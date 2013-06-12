class PandaController < ApplicationController
	skip_before_filter :verify_authenticity_token

	def authorize_upload
		payload = JSON.parse(params['payload'])
		upload = Panda.post('/videos/upload.json', {
			file_name: payload['filename'],
			file_size: payload['filesize'],
			profiles: "h264,ogg,webm",
		})
		render :json => {:upload_url => upload['location']}
	end

	def authorize_upload_audio
		payload = JSON.parse(params['payload'])
		upload = Panda.post('/videos/upload.json', {
			file_name: payload['filename'],
			file_size: payload['filesize'],
			profiles: "mp3,oga",
		})
		render :json => {:upload_url => upload['location']}
	end

	def notifications
		panda_upload = PandaUpload.find_by_panda_id( params["video_id"] )
		if panda_upload
			post = panda_upload.post
			if post
				case panda_upload.media_type
					when "audio"
						audio_file = AudioFile.create( panda_id: panda_upload.panda_id )
						post.audio_album.audio_files << audio_file
					when "video"
						video_file = VideoFile.create( panda_id: panda_upload.panda_id )
						post.video_album.video_files << video_file
				end
				panda_upload.destroy
				post.reload.save
			end
		end
		if post
			render nothing: true if post
		else
			render :text => "404 Not Found", :status => 404
		end
	end

end
