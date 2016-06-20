ruby '2.3.1'

source 'https://rubygems.org'

gem 'rails', '~> 4.2.6'
gem 'rails-i18n'

# Database
gem 'pg'

# Mailing
gem 'mailchimp-api', require: 'mailchimp'
gem 'mailgun_rails'

# Normaliztion
gem 'unicode'
gem 'postrank-uri'

# Authentication and authorization
gem 'devise'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-vkontakte'
gem 'omniauth-github'
gem "omniauth-google-oauth2"
gem "omniauth-twitter"
gem 'cancancan', '~> 1.7'

# Request handling
gem 'responders'
gem 'has_scope'
gem 'friendly_id'
gem 'active_model_serializers', '~> 0.10.0.rc1'

# Decoration
gem 'draper'

# Compile and serve assets
gem 'sass-rails', '~> 6.0.0.beta'
gem 'sprockets-rails'
gem 'sprockets', '~> 4.0.0.beta'
gem 'babel-transpiler'
gem 'jquery-rails'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0'
gem 'styx'
gem 'marked-rails'
gem 'bootstrap-sass'
gem 'font-awesome-sass'
gem 'gon'
gem "autoprefixer-rails"
gem 'csso-rails'
gem 'heroku_rails_deflate', group: :production
gem 'turbolinks'
gem 'jquery-turbolinks'
gem 'momentjs-rails'
gem 'bootstrap3-datetimepicker-rails'

# View template compilers and helpers
gem 'jbuilder', '~> 2.0'
gem 'slim-rails'
gem 'redcarpet'
gem 'active_link_to'
gem 'high_voltage'
gem 'simple_form'

# Caching
gem 'dalli'

# Documentation
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'apipie-rails', git: 'https://github.com/Apipie/apipie-rails.git', ref: 'f697ec2a887cd73c00c846eceb2ce63a050ccb20'

# Application server
gem 'unicorn'

# Environment variables management
gem 'figaro'

# Sexy rails console
gem 'awesome_print'
gem 'pry-rails'

# Heroku compatibility
gem 'rails_12factor'

# Image and AWS S3 management
gem "fog-aws"
gem 'mini_magick'
gem 'carrierwave'
gem 'asset_sync'

# Monitoring
gem 'newrelic_rpm'
gem 'runtimeerror_notifier'

# Utils
gem 'icalendar'

group :development do
  gem 'annotate', require: false
  gem 'quiet_assets'
  gem 'letter_opener'
  gem 'web-console'
end

group :development, :test do
  # Data generator
  gem 'ffaker'

  # Model factories
  gem 'factory_girl_rails'
  gem 'rspec-rails', '~> 3.0'
end

group :test do
  gem 'shoulda-matchers', require: false
  gem "codeclimate-test-reporter", require: false
end
