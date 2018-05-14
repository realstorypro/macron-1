# frozen_string_literal: true

FactoryBot.define do
  factory :category do
    name { Faker::Name.name }
    description { Faker::Name.name }
    association :color, factory: :color
  end
end
