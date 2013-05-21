class SessionsController < ApplicationController
	def create
		user = User.authenticate( params[:user][:login], params[:user][:password] )
		if user
			env['warden'].set_user(user)
		end
		redirect_to feeds_path
	end

	def destroy
		env['warden'].set_user(nil)
		redirect_to root_path
	end
end
