source 'https://rubygems.org'

#Core libraries/ORMS/DSLS
gem 'rails', '3.2.13'
gem 'pg'
gem 'activerecord-postgres-hstore'
gem 'squeel'

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
gem 'rmagick'

#File uploading libraries
gem 'carrierwave'
gem 'fog', "~> 1.3.1"

#Third party service helper libraries
gem 'zencoder'
gem 'panda'

gem 'geokit-rails3'

#Language time and location libraries
gem 'timezone'

#User authintication note devise is required by active admin
gem 'omniauth'
gem 'omniauth-facebook', require: "omniauth-facebook"

#View layer extensions
gem "haml-rails"
gem 'active_link_to'

#Server side fetching/parsing/processing libraries
gem 'link_thumbnailer'
gem 'sanitize'
gem 'html_truncator'


#Cient scripting libraries
gem 'jquery-rails', "2.3.0"
gem 'jquery-ui-rails'
gem 'jquery-modal-rails'
gem 'jbuilder'
gem 'active_model_serializers'
gem "jquery-fileupload-rails", git: "https://github.com/cannapages/jquery-fileupload-rails.git"

#Deployment
gem 'unicorn'
gem 'capistrano'
