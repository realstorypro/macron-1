# frozen_string_literal: true

FactoryBot.define do
  factory :user, aliases: [:member] do
    email { Faker::Internet.unique.email }
    username { Faker::Internet.unique.email }
    password { Faker::Internet.password }
    phone_number { "5202222222" }
    country { "us" }

    after(:create) do |user|
      user.confirm
      user.phone_verified = true
      user.save
    end

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
