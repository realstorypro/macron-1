# frozen_string_literal: true

FactoryBot.define do
  factory :entries_event, class: "entries/event" do
    name { Faker::Name.name }
    description { Faker::Name.name }
    body { Faker::Demographic.race }
    price { "10.99" }
    start_date { Faker::Date.forward(20) }
    end_date { Faker::Date.forward(25) }
    start_time { Faker::Time.forward(20) }
    end_time { Faker::Time.forward(25) }
    location { Faker::Demographic.race }
    long_title { Faker::Name.name }
    long_summary { Faker::Demographic.race }
    published_date { Faker::Date.forward(7) }
    fullscreen_image { Faker::Avatar.image }
    landscape_image { Faker::Avatar.image }
    card_image { Faker::Avatar.image }
    image_alt { Faker::Name.name }
    association :category, factory: :category
    association :user
    after(:create) do |event|
      create(:comment, commentable: event)
    end
  end
end
