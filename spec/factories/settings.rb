FactoryBot.define do
  factory :settings do
    name { Faker::Name.name }
    description { Faker::Name.name }
    url { Faker::Internet.url }
    about { Faker::WorldOfWarcraft.quote }
    address1 { Faker::Address.street_address }
    address2 { Faker::Address.street_address }
    copyrights { Faker::WorldOfWarcraft.quote }
  end
end
