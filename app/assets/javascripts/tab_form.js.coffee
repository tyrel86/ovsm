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
		panda.uploader.init(
			'buttonId': 'video_upload'
			'progressBarId': 'video_progress_bar'
			'onStart': ->
				OvsmLib.upload_cue += 1
			'onSuccess': (file, data) ->
				old_val = $("#post_video_ids").val()
				if old_val == undefined or old_val == ""
					delimiter = ""
				else
					delimiter = ","
				new_val = old_val + delimiter + data.id
				$("#post_video_ids").val( new_val )

			'onComplete': ->
				$("#video_progress_bar").css('width', '0%')
				OvsmLib.upload_cue -= 1
		)

		panda.uploader.init(
			'authorizeUrl': '/panda/authorize_upload_audio'
			'buttonId': 'audio_upload'
			'progressBarId': 'audio_progress_bar'
			'onStart': ->
				OvsmLib.upload_cue += 1
			'onSuccess': (file, data) ->
				old_val = $("#post_audio_ids").val()
				if old_val == undefined or old_val == ""
					delimiter = ""
				else
					delimiter = ","
				new_val = old_val + delimiter + data.id
				$("#post_audio_ids").val( new_val )
				console.log data

			'onComplete': (file,data) ->
				$("#audio_progress_bar").css('width', '0%')
				OvsmLib.upload_cue -= 1
		)

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


	)
