require 'faker'

FactoryGirl.define do
  factory :location do |f|
    f.name { Faker::Name.title }
    f.address { Faker::Address.street_address }
    f.url { Faker::Internet.url }
    f.latitude { Faker::Address.latitude }
    f.longitude { Faker::Address.longitude }
  end
end