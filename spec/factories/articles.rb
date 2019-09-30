# frozen_string_literal: true

FactoryBot.define do
  factory :article do
    name { Faker::Name.name }
    description { Faker::Name.name }
    published_date { Faker::Date.backward(7) }
    landscape_image { Faker::Avatar.image }
    card_image { Faker::Avatar.image }
    image_alt { Faker::Name.name }
    association :category, factory: :category
    association :user
    after(:create) do |article|
      create(:comment, commentable: article)
    end
  end
end
