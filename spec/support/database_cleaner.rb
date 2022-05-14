# frozen_string_literal: true

require 'database_cleaner'

DatabaseCleaner.allow_remote_database_url = true
DatabaseCleaner.strategy = :transaction

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end
