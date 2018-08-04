# frozen_string_literal: true

FactoryBot.define do
  factory :discussion do
    name { Faker::Name.unique.name }
    description { Faker::Name.name }
    body { Faker::Demographic.race }
    long_title { Faker::Name.name }
    long_summary { Faker::Demographic.race }
    published_date { Faker::Date.forward(7) }
    association :category, factory: :category
  end
end
