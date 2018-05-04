# frozen_string_literal: true

FactoryBot.define do
  factory :discussion, class: Discussion do
    body { Faker::Demographic.race }
    summary { Faker::Demographic.race }
    name { Faker::Name.unique.name }
    published_date { Faker::Date.forward(7) }
    association :category, factory: :category
    association :user, factory: :user
  end
end
