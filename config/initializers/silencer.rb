# frozen_string_literal: true

if Rails.env.development?
  require 'silencer/logger'

  Rails.application.configure do
    config.middleware.swap(
      Rails::Rack::Logger,
      Silencer::Logger,
      config.log_tags,
      get: [%r{^/images/aws_host/uploads/}]
    )
  end
end
