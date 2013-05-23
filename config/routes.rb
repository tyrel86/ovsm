Ovsm::Application.routes.draw do
  resources :page_links

  use_link_thumbnailer

	#For now use a custom login controller switch back to devise latter
	resources :sessions, only: [:create]
	match "/sessions/logout" => "sessions#destroy", as: :sessions_destroy
	devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
	devise_scope :user do
		root to: "devise/registrations#new"
	end
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

	get "/feeds" => "feeds#index", as: :user_root
	post "/feeds/fly_and_show" => "feeds#fly_and_show", as: :fly_and_show
  resources :feeds

	resources :posts
	resources :square_photos
	resources :audio_files
	resources :video_files
end
