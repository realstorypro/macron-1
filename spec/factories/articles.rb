# frozen_string_literal: true

FactoryBot.define do
  factory :article, class: Article do
    name { Faker::Name.name }
    body { Faker::Demographic.race }
    title { Faker::Name.name }
    internal_title { Faker::Name.name }
    summary { Faker::Demographic.race }
    internal_summary { Faker::Demographic.race }
    author { Faker::Name.name }
    published_date { Faker::Date.forward(7) }
    header_image { Faker::Avatar.image }
    list_image { Faker::Avatar.image }
    featured_image { Faker::Avatar.image }
    association :category, factory: :category
  end
end
