require 'faker'

FactoryGirl.define do
  factory :category do |f|
    f.name { Faker::Lorem.word.capitalize() }

    trait :parent_id do
      parent_id 4
    end
  end
end