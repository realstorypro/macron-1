# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    body { Faker::Demographic.race }
    association :commentable
    association :user
  end
end
