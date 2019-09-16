# frozen_string_literal: true

FactoryBot.define do
  factory :user, aliases: [:member] do
    email { Faker::Internet.unique.email }
    username { rand(1..5).to_s + Faker::Internet.unique.email }
    password { Faker::Internet.password }
    country { "us" }
    phone_verified { true }

    after(:create) do |user|
      # this is a little ugly, but we want to make sure that the number
      # we are generating is a valid mobile phone number
      user.phone_number = "520#{%w(370 213 220 221).sample}#{rand.to_s[2..5]}"
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
