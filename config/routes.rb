Ovsm::Application.routes.draw do
  resources :feeds


  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
end
