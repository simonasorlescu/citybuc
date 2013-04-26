require 'faker'

FactoryGirl.define do
  factory :review do |f|
    f.title { Faker::Name.title }
    f.description { Faker::Lorem.paragraph }
    f.rating nil
  end
end