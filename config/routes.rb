Ovsm::Application.routes.draw do
	post "/feeds/fly_and_show" => "feeds#fly_and_show", as: :fly_and_show
  resources :feeds


  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
end
