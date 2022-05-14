# frozen_string_literal: true

if ENV['CI'] == 'true'
  require 'simplecov'
  SimpleCov.start 'rails'

  require 'codecov'
  SimpleCov.formatter = SimpleCov::Formatter::Codecov
end
