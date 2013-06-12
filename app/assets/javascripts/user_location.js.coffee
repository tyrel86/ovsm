jQuery ->
	geoSuccess = (response) ->
		OvsmLib.user_location_lat = response.coords.latitude
		OvsmLib.user_location_lng = response.coords.longitude
		true
	geoFailur = (response) ->
		alert("Sory we were unable to determin your location we will default to less acurate mesures some location based functionality may behave inperfectly.")
		OvsmLib.user_location_lat = ""
		OvsmLib.user_location_lng = ""
		false
	navigator.geolocation.getCurrentPosition( geoSuccess, geoFailur )
