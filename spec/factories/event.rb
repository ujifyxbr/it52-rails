FactoryGirl.define do
  factory :event do
    title { Faker::Lorem.words(4).join(' ') }
    place { Faker::Address.street_address }
    association :organizer, factory: :user

    trait :with_markdown do
      description { %(I'm **description** with _markdown_.) }
    end
  end
end
