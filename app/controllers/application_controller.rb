class ApplicationController < ActionController::Base
  protect_from_forgery

	layout :layout_by_resource

	private
	def fall_back_lat_lng_from_ip
		geo = Geokit::Geocoders::IpGeocoder.geocode(request.remote_ip)
		[geo.lat, geo.lng]
	end

	def after_sign_in_path_for(resource)
		feeds_path
	end
	
	def layout_by_resource
		if devise_controller?
			if resource_name == :user
				"user_devise"
			elsif resource_name == :business
				"business_devise"
			end
		else
			"application"
		end
	end

end
