FactoryBot.define do
  factory :subscription do
    title { Faker::Sports::Basketball.team }
    price { Faker::Number.decimal(l_digits: 2) }
    status { Faker::Number.between(from: 0, to: 1) }
    frequency { Faker::Number.between(from: 0, to: 2) }
    tea { Tea.all.shuffle.sample }
    customer { Customer.all.shuffle.sample }
  end
end
