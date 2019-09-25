# frozen_string_literal: true

FactoryBot.define do
  factory :entries_advertisement, class: "entries/advertisement" do
    name { Faker::Name.name }
    url { Faker::Internet.url }
    title { Faker::Job.title }
    text { Faker::Name.name }
    image { Faker::Avatar.image }
    association :category, factory: :category
    published_date { Faker::Date.forward(7) }
  end
end
