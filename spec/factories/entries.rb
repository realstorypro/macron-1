FactoryBot.define do
  factory :entry do
    name { Faker::Name.name }
    association :category, factory: :category
  end
end
