jQuery ->
	#Set up JS environment
	OvsmLib.upload_cue = 0
	OvsmLib.allow_form_submition = true


	#Set nav bar active link to parrent
	$("a.active").first().parent().addClass("active")
	
	#Signup form click listener
	$(".sign_up_button").unbind('click').click ->
		$(".sign_up_form").slideToggle("slow")
