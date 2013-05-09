source 'https://rubygems.org'

#Core libraries
gem 'rails', '3.2.13'
gem 'pg'

#Asset pipeline
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
  gem 'compass-rails'
end

#Testing and test data
gem 'faker'
gem 'factory_girl'
group :test, :development do
  gem "rspec-rails", "~> 2.0"
end

#Debugging tools
group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'meta_request'
	gem 'debugger'
end

#Active Record Extentions
gem 'activeadmin'
gem 'bcrypt-ruby', '~> 3.0.0'
gem 'simple_form'
gem "rmagick"
gem 'carrierwave'
gem "fog"

#Language time and location libraries
gem 'timezone'

#User authintication not devise is required by active admin
gem 'omniauth'
gem 'omniauth-facebook', require: "omniauth-facebook"

#View layer extensions
gem "haml-rails"
gem 'active_link_to'

#Cient scripting libraries
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'jquery-modal-rails'
gem 'jbuilder'
gem 'active_model_serializers'
gem "jquery-fileupload-rails", git: "https://github.com/cannapages/jquery-fileupload-rails.git"

#Deployment
gem 'unicorn'
gem 'capistrano'
