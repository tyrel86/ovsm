#Small tasks and initilizers
jQuery ->
	#Set up JS environment
	OvsmLib.upload_cue = 0
	OvsmLib.allow_form_submition = true
	OvsmLib.file_type_mappings =
		#Video
		mpg: "video/mp4"
		mp4: "video/mp4"
		ogv: "video/ogg"

	#Set nav bar active link to parrent
	$("a.active").first().parent().addClass("active")
	
	#Signup form click listener
	$(".sign_up_button").unbind('click').click ->
		$(".sign_up_form").slideToggle("slow")
		$("#user_lat").val(OvsmLib.user_location_lat)
		$("#user_lng").val(OvsmLib.user_location_lng)

	#Set up video show modal for feeds
	$(document).on( $.modal.AJAX_COMPLETE, ->
		feed_video = $(".feed_video_holder").first()
		if feed_video.size() > 0
			feed_video.parent().addClass("feed_video_modal")
			feed_video.flowplayer()
	)
