# frozen_string_literal: true

FactoryBot.define do
  factory :profile, class: Profile do
    avatar { Faker::Avatar.image }
    location { Faker::Job.title }
    bio { Faker::Seinfeld.quote }
  end
end
