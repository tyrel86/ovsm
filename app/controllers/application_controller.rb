class ApplicationController < ActionController::Base
  protect_from_forgery

	layout :layout_by_resource

	private
	def fall_back_lat_lng_from_ip
		geo = Geokit::Geocoders::IpGeocoder.geocode(request.remote_ip)
		[geo.lat, geo.lng]
	end

	def after_sign_in_path_for(resource)
		if resource.is_a? User
			feeds_path
		elsif resource.is_a? Business
			feed_path resource.feed
		end
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

	def require_login
		redirect_to root_path unless user_signed_in? or business_signed_in?
	end

end
