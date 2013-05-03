require 'faker'

FactoryGirl.define do
  factory :user do |f|
    f.username { Faker::Name.name }
    f.email { Faker::Internet.email }
    f.password "foobar12"
    f.password_confirmation "foobar12"
  end

  factory :invalid_user, parent: :user do |f|
    f.username nil
  end
end