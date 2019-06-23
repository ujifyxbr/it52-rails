ruby '2.6.3'

source 'https://rubygems.org'

gem 'rails', '~> 5.2.0'
gem 'bootsnap'

# Databases
gem 'pg'
gem 'hiredis'
gem 'redis'

# Queue
gem 'sidekiq'

# Integrations
gem 'mailchimp-api', require: 'mailchimp'
gem 'mailgun_rails'
gem 'http'

# Normaliztion
gem 'unicode'
gem 'postrank-uri'

# Authentication and authorization
gem 'devise'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-vkontakte'
gem 'omniauth-github'
gem 'omniauth-google-oauth2'
gem 'omniauth-twitter'
gem 'cancancan'

# Request handling
gem 'has_scope'
gem 'friendly_id'

# Decoration
gem 'active_model_serializers'
gem 'fast_jsonapi'
gem 'oj'
gem 'ox'
gem 'activemodel-serializers-xml'
gem 'draper'

# Compile and serve assets
gem 'uglifier'
gem 'sassc-rails'
gem 'font-awesome-sass'
gem 'autoprefixer-rails'
gem 'csso-rails'
gem 'webpacker'

# View template compilers and helpers
gem 'jbuilder', '~> 2.5'
gem 'slim-rails'
gem 'redcarpet'
# gem 'active_link_to'
gem 'high_voltage'
gem 'simple_form'
gem 'meta-tags'

# Reporting
gem 'jwt'

# Documentation
gem 'sdoc', group: :doc
# gem 'apipie-rails', git: 'https://github.com/Apipie/apipie-rails.git', ref: 'f697ec2a887cd73c00c846eceb2ce63a050ccb20'

# Application server
gem 'puma-rails'
gem 'foreman'

# Environment variables management
gem 'figaro'

# Sexy rails console
gem 'awesome_print'
gem 'pry-rails'

# Image and AWS S3 management
gem 'fog-aws', '< 3'
gem 'asset_sync'
gem 'mini_magick'
gem 'carrierwave'
gem 'carrierwave-imageoptimizer'

# Monitoring
gem 'newrelic_rpm'
gem 'rollbar'
gem 'silencer'

# Utils
gem 'icalendar'

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console'
  gem 'listen', '~> 3.1.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  gem 'annotate', require: false
  gem 'letter_opener'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
  # gem 'travis'

  # Data generator
  gem 'ffaker'

  # Model factories
  gem 'factory_bot_rails'
  gem 'rspec-rails'
end

group :test do
  gem 'codeclimate-test-reporter'
  gem 'simplecov'
  gem 'codecov', require: false
  gem 'shoulda-matchers', require: false
  gem 'database_cleaner'
  gem 'webmock'
end

# Heroku compatibility
gem 'rails_12factor', group: :production

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

#paginator
gem 'kaminari'

#tags
gem 'acts-as-taggable-on'
