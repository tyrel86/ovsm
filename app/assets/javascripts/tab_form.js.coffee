jQuery ->
	# Handel for ajax modal load
	$(document).on( $.modal.AJAX_COMPLETE, ->
		#Update the post lat and lng
		$("#post_lat").val(OvsmLib.user_location_lat)
		$("#post_lng").val(OvsmLib.user_location_lng)

		# Set up modal nav links to change content
		$(".tabular_form .nav .link").click( ->
			$(".tabular_form .tab.active").removeClass("active")
			$(".tabular_form .link.active").removeClass("active")
			suffix = $(this).attr('id')
			$( "#" + suffix + "_tab" ).addClass("active")
			$(this).addClass("active")
		)

		#Form submition handle
		$(".submit_post").click( ->
			if OvsmLib.allow_form_submition
				$("#new_post").submit()
			else
				alert("Some file uploads are still being prosessed by the server")
		)

		#Handle Upload Que Changes
		OvsmLib.watch("upload_cue", (id, old_val, new_val) ->
			if old_val == 0 and new_val > 0
				OvsmLib.allow_form_submition = false
				$(".processing").show()
				$(".submit_post").addClass("off")

			if old_val > 0 and new_val == 0
				OvsmLib.allow_form_submition = true
				$(".processing").hide()
				$(".submit_post").removeClass("off")

			return new_val
		)

		# Set up ajax file uploaders
		$("#new_square_photo").fileupload
			dataType: "script"
			replaceFileInput: false
			add: (e, data) ->
				$("#upload_photo").on('click', ->
					OvsmLib.upload_cue += 1
					OvsmLib.last_upload = data
					data.context = $($.parseHTML(tmpl("photo_upload_progress_bars", data.files[0])))
					$("#photo_upload_progress_container").append(data.context)
					data.submit()
					$("#square_photo_caption").val("")
					$("#photo_upload_progress_devider").show()
				)
			progress: (e, data) ->
				if data.context
					progress = parseInt(data.loaded / data.total * 100, 10)
					data.context.find('.bar').css('width', progress + '%')
			start: (e, data) ->
				$("#upload_photo").unbind('click')

		$("#new_audio_file").fileupload
			dataType: "script"
			add: (e, data) ->
				$("#upload_audio").on('click', ->
					OvsmLib.upload_cue += 1
					data.context = $($.parseHTML(tmpl("audio_upload_progress_bars", data.files[0])))
					$("#audio_upload_progress_container").append(data.context)
					data.submit()
					$("#audio_file_name").val("")
					$("#audio_upload_progress_devider").show()
				)
			progress: (e, data) ->
				if data.context
					progress = parseInt(data.loaded / data.total * 100, 10)
					data.context.find('.bar').css('width', progress + '%')
			start: (e, data) ->
				$("#upload_audio").unbind('click')

		$("#new_video_file").fileupload
			dataType: "script"
			add: (e, data) ->
				$("#upload_video").on('click', ->
					OvsmLib.upload_cue += 1
					data.context = $($.parseHTML(tmpl("video_upload_progress_bars", data.files[0])))
					$("#video_upload_progress_container").append(data.context)
					data.submit()
					$("#video_file_name").val("")
					$("#video_upload_progress_devider").show()
				)
			progress: (e, data) ->
				if data.context
					progress = parseInt(data.loaded / data.total * 100, 10)
					data.context.find('.bar').css('width', progress + '%')
			start: (e, data) ->
				$("#upload_video").unbind('click')

	)
