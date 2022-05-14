# frozen_string_literal: true

REDIS_OPTIONS = { url: ENV.fetch('REDIS_URL') { 'redis://redis:6379' },
                  db: 1 }.freeze

Sidekiq.configure_server do |config|
  config.redis = REDIS_OPTIONS.dup
end

Sidekiq.configure_client do |config|
  config.redis = REDIS_OPTIONS.dup
end
