Ovsm::Application.routes.draw do
	devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
	devise_scope :user do
		root to: "devise/registrations#new"
	end

	get "/feeds" => "feeds#index", as: :user_root
  devise_for :users

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

	post "/feeds/fly_and_show" => "feeds#fly_and_show", as: :fly_and_show
  resources :feeds
end
