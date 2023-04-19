FactoryBot.define do
  factory :tea do
    title { Faker::Tea.variety }
    description { Faker::Coffee.notes }
    temperature { Faker::Number.between(from: 100.0, to: 150.0) }
    brew_time { Faker::Number.number(digits: 2) }
  end
end
