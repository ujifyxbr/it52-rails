FactoryGirl.define do
  factory :event do
    title       { Faker::Lorem.words(4).join(' ') }
    description { Faker::Lorem.paragraphs(3).join("\n\n") }
    place       { Faker::Address.street_address }
    started_at  { 1.month.from_now }
    association :organizer, factory: :user

    trait :with_markdown do
      description { %(I'm **description** with _markdown_.) }
    end
  end
end
