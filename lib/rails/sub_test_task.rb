# frozen_string_literal: true

# Draper workaround for Rails 5
require 'rake/testtask'

class Rails::SubTestTask < Rake::TestTask
end