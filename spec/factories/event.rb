# frozen_string_literal: true

FactoryBot.define do
  factory :event do
    title       { FFaker::Lorem.words(4).join(' ') }
    description { FFaker::Lorem.paragraphs(3).join("\n\n") }
    place       { FFaker::Address.street_address }
    started_at  { 1.month.from_now }
    tag_list    { FFaker::Lorem.words(2) }
    organizer   { create(:user) }

    trait :with_markdown do
      description { %(I'm **description** with _markdown_.) }
    end

    trait :published do
      published_at { Time.current }
      published { true }
    end
  end
end
