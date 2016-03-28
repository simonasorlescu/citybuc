require 'faker'

FactoryGirl.define do
  factory :location do |f|
    f.name { Faker::Name.title }
    f.address { Faker::Address.street_address }
    f.url { Faker::Internet.url }
    # f.latitude 45.243242
    # f.longitude -120.214324
    # f.latitude { Faker::Address.latitude.to_f.round(6) }
    # f.longitude { Faker::Address.longitude.to_f.round(6) }
  end
end