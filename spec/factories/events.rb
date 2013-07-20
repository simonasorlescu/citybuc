require 'faker'

FactoryGirl.define do
  factory :event do |f|
    f.name { Faker::Name.name }
    f.description { Faker::Lorem.paragraph }
    f.url { Faker::Internet.url }
    f.date { rand(10.months).ago }
    f.picture do
      j = rand(1..6)
      img = "img/test/#{j}.jpg"
    end
  end
end