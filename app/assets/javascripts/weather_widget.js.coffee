jQuery ->
	api_id = $("weather_api_id").data("id")
	uri = "http://api.openweathermap.org/data/2.1/forecast/city/" + api_id
		
