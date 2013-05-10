class ApplicationController < ActionController::Base
  protect_from_forgery

	private
	def fall_back_lat_lng_from_ip
		geo = Geokit::Geocoders::IpGeocoder.geocode(request.remote_ip)
		[geo.lat, geo.lng]
	end
end
