Ovsm::Application.routes.draw do

  use_link_thumbnailer

	#For now use a custom login controller switch back to devise latter
	devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks", registrations: "users/registrations", sessions: "users/sessions" }
	devise_scope :user do
		root to: "devise/registrations#new"
	end
  devise_for :admin_users, ActiveAdmin::Devise.config
  devise_for :businesses
	get "/feeds/business_root" => "feeds#business_root", as: :business_root
  ActiveAdmin.routes(self)

	resources :users

	get "/feeds" => "feeds#index", as: :user_root
	post "/feeds/fly_and_show" => "feeds#fly_and_show", as: :fly_and_show
  resources :feeds do
		resources :feed_videos, only: [:show]
	end

	resources :posts
	resources :square_photos
	resources :audio_files
	resources :video_files
	match "/panda/authorize_upload", :to => "panda#authorize_upload"
	match "/panda/authorize_upload_audio", :to => "panda#authorize_upload_audio"
	match "/panda/notifications", to: "panda#notifications"

	get "/suitcases/:id/add_post/:post_id" => "suitcases#add_post"
	get "/suitcases/:id/remove_post/:post_id" => "suitcases#remove_post"
	get "/suitcases/post_ids_for_current_user" => "suitcases#post_ids_for_current_user"
end
