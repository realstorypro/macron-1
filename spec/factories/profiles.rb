# frozen_string_literal: true

FactoryBot.define do
  factory :profile do
    user
    title { Faker::Job.title }
    avatar { Faker::Avatar.image }
    age { rand(20..80) }
    location { Faker::Job.title }
    signature { Faker::Seinfeld.quote }
    verified { false }
  end
end
