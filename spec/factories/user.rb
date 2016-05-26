require 'faker'

FactoryGirl.define do
  factory :user do |f|
    f.name { Faker::Name.name }
    f.email { Faker::Internet.email }
    f.alias { Faker::Superhero.name }
    password "12345678"
    password_confirmation "12345678"
  end
end
