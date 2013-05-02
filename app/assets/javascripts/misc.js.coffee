jQuery ->
	$("a.active").first().parent().addClass("active")
	$(".sign_up_button").click ->
		$(".sign_up_form").toggle("slow")
