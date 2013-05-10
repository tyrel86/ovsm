jQuery ->
	geoip2Success = (response) ->
		OvsmLib.user_location_lat = response.location.latitude
		OvsmLib.user_location_lng = response.location.longitude
	geoip2Failur = (response) ->
		OvsmLib.user_location_lat = ""
		OvsmLib.user_location_lng = ""
	geoip2.city( geoip2Success, geoip2Failur )
