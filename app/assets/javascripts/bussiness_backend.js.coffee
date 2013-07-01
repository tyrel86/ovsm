jQuery ->
	$(".business_sign_up").click( ->
		form_id_to_reveal = $(this).attr('id') + "_form"
		console.log form_id_to_reveal
		$(".business_sign_up_form").hide()
		$( "#" + form_id_to_reveal ).show()
	)
