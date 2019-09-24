# frozen_string_literal: true

FactoryBot.define do
  factory :user, aliases: [:member] do
    email { Faker::Internet.unique.email }
    username { rand(1..5).to_s + Faker::Internet.unique.email }
    password { Faker::Internet.password }

    after(:create) do |user|
      user.country = "us"
      user.phone_number = Faker::PhoneNumber.cell_phone
      user.save

      # we have to set verified to true after the first save,
      # because changing phone number unverifies it.
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
