jQuery ->
	$(".add_to_luggage").click( ->
		event.stopPropagation()
		alert("Clicked")
		if $(this).hasClass("added")
			$.ajax( "/suitcases/1/remove_post/#{$(this).data('post-id')}")
			$(this).removeClass("added")
		else
			$.ajax( "/suitcases/1/add_post/#{$(this).data('post-id')}")
			$(this).addClass("added")
	)
