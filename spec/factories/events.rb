# frozen_string_literal: true

FactoryBot.define do
  factory :event do
    name { Faker::Name.name }
    description { Faker::Name.name }
    body { Faker::Demographic.race }
    ticket_link { 'https://www.picatic.com/209619' }
    price { '10.99' }
    start_date { Faker::Date.forward(20) }
    end_date { Faker::Date.forward(25) }
    long_title { Faker::Name.name }
    long_summary { Faker::Demographic.race }
    published_date { Faker::Date.forward(7) }
    fullscreen_image { Faker::Avatar.image }
    landscape_image { Faker::Avatar.image }
    card_image { Faker::Avatar.image }
    image_alt { Faker::Name.name }
    association :category, factory: :category
    after(:create) do |event|
      create(:comment, commentable: event)
    end
  end
end
