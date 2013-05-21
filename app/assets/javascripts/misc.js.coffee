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
		#Audio
		mp3: "audio/mp3"

	#Initilize Sound Manager
	soundManager.url = '/assets/soundmanager2_flash9.swf'
	soundManager.flashVersion = 9
	soundManager.useHTML5Audio = true
	soundManager.debugMode = false

	#Set nav bar active link to parrent
	$("a.active").first().parent().addClass("active")
	
	#Signup form click listener
	$(".sign_up_button").unbind('click').click ->
		$(".sign_up_form").slideToggle("slow")
