require "faker"
FactoryGirl.define do
  factory :user do |f|
    f.email { Faker::Internet.email }
    f.password { Faker::Lorem.characters(6) }
  end
end

