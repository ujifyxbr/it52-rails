pass = Devise.friendly_token

FactoryGirl.define do
  factory :user do
    email       { Faker::Internet.email }
    first_name  { Faker::Name.first_name }
    last_name   { Faker::Name.last_name }
    password    { pass }
    password_confirmation { pass }
    remember_me { false }
    confirmed_at { Time.now }

    factory :admin do
      role   { :admin }
    end

    factory :unconfirmed_user do
      confirmed_at { nil }
    end
  end
end
