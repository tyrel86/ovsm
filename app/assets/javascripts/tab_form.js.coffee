jQuery ->
	# Handel for ajax modal load
	$(document).on( $.modal.AJAX_COMPLETE, ->
		if $(".post-show").size() == 0
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

			$("input[name='post[location_type]']").change( ->
				if $(this).val() == "cust"
					$(".opt-loc").show()
				else
					$(".opt-loc").hide()
			)
			

			#Form submition handle
			$(".submit_post").click( ->
				if $(".promo").size() == 0
					if OvsmLib.allow_form_submition
						$("#new_post").submit()
					else
						alert("Some file uploads are still being prosessed by the server")
				if $(".promo").size() == 1
					suffix = $(".tab.active").find("form").submit()
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
		else
			$(".post-show").css("top","50px")
			$(".post-show").css("margin-top","0px")
			$(".post-show").css("max-height","#{$(window).height() - 100}px")
			$(".post-show-container .left .link .title").click( ->
				$(".link .title.active").removeClass("active")
				$(this).addClass("active")

				$(".media.active").removeClass("active")
				$(".media[data-media-type=" + $(this).data("media-type") + "]").addClass("active")
				$(".image_galery .caption").css('width', $(".image_galery img.active").css('width'))
			)
			playlist = []
			$(".right video_file").each( (i,e) ->
				playlist.push([
					mp4: $(e).data("mp4")
					webm: $(e).data("webm")
					ogg: $(e).data("ogg")
					]
				)
			)
			$("#jp_playlist_post_show").flowplayer(
				 playlist: playlist
			)
			play_list = OvsmLib.play_list_from_modal_album()
			console.log play_list
			new jPlayerPlaylist({
				jPlayer: "#jquery_jplayer_post_show",
				cssSelectorAncestor: "#jp_container_post_show"
			}, play_list, {
				swfPath: "/assets",
				supplied: "oga, mp3",
				wmode: "window",
				smoothPlayBar: true,
				keyEnabled: true
			})
			$(".image_galery .caption").css('width', $(".image_galery img.active").css('width'))
			$(".image_galery .selection img").click( ->
				$(".image_galery img.active").removeClass("active")
				new_url = $(this).attr('src').replace("thumb_","")
				$(".image_galery img[src='#{new_url}']").addClass("active")

				$(".image_galery .selection .selected").removeClass("selected")
				$(this).addClass("selected")
				$(".image_galery .caption").html( $(this).data("caption") )
				if $(this).data("caption") == ""
					$(".image_galery .caption").hide()
				else
					$(".image_galery .caption").show()
				$(".image_galery .caption").css('width', $(".image_galery img.active").css('width'))
			)
	)
