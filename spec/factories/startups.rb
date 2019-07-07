# frozen_string_literal: true

FactoryBot.define do
  factory :startup do
    title       { FFaker::Company.name }
    url         { FFaker::Internet.http_url }
    logo        { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/logo.png'), 'image/png') }
    intro       { FFaker::Company.catch_phrase }
    description { FFaker::LoremRU.paragraphs(5).join("\n\n") }
    contacts    { { contacts: [{ name: FFaker::Name.name, email: FFaker::Internet.email }] } }
    author      { create(:user) }
  end
end
