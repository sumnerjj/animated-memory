require "faker"

FactoryGirl.define do
  factory :post do |f|
    f.title { Faker::Lorem.word }
    f.body { Faker::Lorem.paragraph(4) }
  end
end
