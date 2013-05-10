jQuery ->
	geoip2Success = (response) ->
		console.log( response )
		OvsmLib.user_location_lat = response.location.latitude
		OvsmLib.user_location_lng = response.location.longitude
	geoip2Failur = (response) ->
		alert( "Our server was unable to refine your experience based on your location. Your posts will default to your home town even if you are some where else. To change this behavior to allow you to post from where you are please give us permission to access your location in your browser settings. We only use your location information to make your experience better. Thank you." )
	geoip2.city( geoip2Success, geoip2Failur )
