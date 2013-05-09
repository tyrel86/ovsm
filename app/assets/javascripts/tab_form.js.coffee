jQuery ->
	# Handel for ajax modal load
	$(document).on( $.modal.AJAX_COMPLETE, ->
		# Set up modal nav links to change content
		$(".tabular_form .nav .link").click( ->
			$(".tabular_form .tab.active").removeClass("active")
			$(".tabular_form .link.active").removeClass("active")
			suffix = $(this).attr('id')
			$( "#" + suffix + "_tab" ).addClass("active")
			$(this).addClass("active")
		)

		# Set up ajax file uploaders
		$("#new_square_photo").fileupload
			dataType: "script"
			add: (e, data) ->
				$("#upload_photo").on('click', ->
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

	)
