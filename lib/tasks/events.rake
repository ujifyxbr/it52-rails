# frozen_string_literal: true

namespace :events do
  desc 'Update events pageviews from Google Analytics'
  task update_pageviews: :environment do
    UpdateEventPageviews.perform
  end
end
