require 'faker'

FactoryGirl.define do
  factory :user do |f|
    f.username { Faker::Name.name }
    f.email { Faker::Internet.email }
    f.password "foobar12"
    f.password_confirmation { |u| u.password }
  end

  factory :invalid_user, parent: :user do |f|
    f.username nil
  end
end