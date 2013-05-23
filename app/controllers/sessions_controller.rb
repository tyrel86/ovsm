class SessionsController < ApplicationController
	def create
		user = User.authenticate( params[:user][:login], params[:user][:password] )
		if user
			env['warden'].set_user(user)
			if params[:user][:remember_me]
				cookies[:remember_me] = remember_string
				user.remember_me = cookies[:remember_me] 
			end
		end
		redirect_to feeds_path
	end

	def destroy
		env['warden'].set_user(nil)
		cookies[:remember_me] = nil
		redirect_to root_path
	end

	private
	def remember_string
		SecureRandom.uuid
	end
end
