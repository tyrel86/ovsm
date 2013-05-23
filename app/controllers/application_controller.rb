class ApplicationController < ActionController::Base
  protect_from_forgery

	private
	def require_user
		if not current_user and cookies[:remember_me]
			user = User.find_by_remember_me( cookies[:remember_me] )
			if user
				env['warden'].set_user( user )
			end
		end
		redirect_to new_user_session_path unless current_user
	end

	def fall_back_lat_lng_from_ip
		geo = Geokit::Geocoders::IpGeocoder.geocode(request.remote_ip)
		[geo.lat, geo.lng]
	end

	def after_sign_in_path_for(resource)
		feeds_path
	end
end
