# frozen_string_literal: true

FactoryBot.define do
  factory :user, aliases: [:member] do
    email { Faker::Internet.unique.email }
    username { rand(1..5).to_s + Faker::Internet.unique.email }
    password { Faker::Internet.password }
    country { "us" }
    phone_verified { true }

    trait :admin do
      after(:create) do |user|
        user.add_role(:admin)
      end
    end

    trait :banned do
      after(:create) do |user|
        user.add_role(:banned)
      end
    end
  end
end
