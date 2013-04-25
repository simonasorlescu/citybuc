require 'faker'

FactoryGirl.define do
  factory :event do |f|
    f.name { Faker::Name.name }
    f.description { Faker::Lorem.paragraph }
    f.url { Faker::Internet.url }
  end
end