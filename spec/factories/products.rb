# frozen_string_literal: true

FactoryBot.define do
  factory :product, aliases: [:store] do
    name { Faker::Name.name }
    description { Faker::Name.name }
    price { Faker::Number.number(3) }
    product_link { "https://oh-its-leonid.shopify.com/admin/products/1405444358214" }
    body { Faker::Demographic.race }
    long_title { Faker::Name.name }
    long_summary { Faker::Demographic.race }
    published_date { Faker::Date.forward(7) }
    fullscreen_image { Faker::Avatar.image }
    landscape_image { Faker::Avatar.image }
    card_image { Faker::Avatar.image }
    image_alt { Faker::Name.name }
    association :category, factory: :category
    association :user
    after(:create) do |product|
      create(:comment, commentable: product)
    end
  end
end
