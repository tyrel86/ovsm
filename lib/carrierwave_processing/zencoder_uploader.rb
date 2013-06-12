module CarrierWave
  module ZenCoder
		module Audio
			def zencode(*args)
				params = {
					:input         => model.file.url,
					:test          => true,
					:pass_through  => @model.id,
					:notifications => [
						"thewhitetyrel@gmail.com"
					],
					:outputs => [
						{
							:public      => true,
							:base_url    => base_url,
							:filename    => filename_without_ext + '.mp3',
						}, {
							:public      => true,
							:base_url    => base_url,
							:filename    => filename_without_ext + '.ogg',
					 }
				 ]
				}
				#Only in production
				params[:notifications] = [zencoder_audio_url] if Rails.env == "production"

				z_response = Zencoder::Job.create(params)
				@model.zen_meta[:request] = z_response.body
				@model.save
			end
		end
		module Video
			def zencode(*args)
				params = {
					:input         => model.file.url,
					:test          => true,
					:pass_through  => @model.id,
					:notifications => [
						"thewhitetyrel@gmail.com"
					],
					:outputs => [
						{
							:public      => true,
							:base_url    => base_url,
							:filename    => filename_without_ext + '.webm',
						}, {
							:public      => true,
							:base_url    => base_url,
							:filename    => filename_without_ext + '.mp4',
						}, {
							:public      => true,
							:base_url    => base_url,
							:filename    => filename_without_ext + '.ogv',
					 }
				 ]
				}
				#Only in production
				params[:notifications] = [zencoder_audio_url] if Rails.env == "production"

				z_response = Zencoder::Job.create(params)
				@model.zen_meta[:request] = z_response.body
				@model.save
			end
		end
		module UrlHelpers
			def filename_without_ext
				@filename_without_ext ||= File.basename(@model.file.url, File.extname(@model.file.url))
			end

			def base_url
				@base_url ||= File.dirname(@model.file.url)
			end

			def url_for_format(extension)
				base_url + '/' + filename_without_ext + '.' + extension
			end
		end
  end
end
