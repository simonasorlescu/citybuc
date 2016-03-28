require 'faker'

FactoryGirl.define do
  factory :medium do |f|
    f.title { Faker::Name.title }
    f.url { Faker::Internet.url }
  end
end