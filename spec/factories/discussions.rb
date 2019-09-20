# frozen_string_literal: true

FactoryBot.define do
  factory :discussion do
    name { Faker::Name.unique.name }
    description { Faker::Name.name }
    published_date { Faker::Date.forward(7) }
    association :category, factory: :category
    association :user
  end
end
