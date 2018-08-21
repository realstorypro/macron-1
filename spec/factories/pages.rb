# frozen_string_literal: true

FactoryBot.define do
  factory :page do
    name { Faker::Name.name }
    description { Faker::Name.name }
    after(:create) do |article|
      create(:comment, commentable: article)
    end
  end
end
