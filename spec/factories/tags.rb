# frozen_string_literal: true

FactoryBot.define do
  factory :tag, class: Tag do
    name { Faker::Name.name }
  end
end
