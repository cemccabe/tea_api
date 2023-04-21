Customer.destroy_all
Tea.destroy_all
Subscription.destroy_all

10.times do
  Customer.create!({
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    address: Faker::Address.full_address
  })
end

50.times do
  Tea.create!({
    title: Faker::Tea.variety,
    description: Faker::Coffee.notes,
    temperature: Faker::Number.between(from: 100.0, to: 150.0),
    brew_time: Faker::Number.number(digits: 2)
  })
end

30.times do
  Subscription.create!({
    title: Faker::Sports::Basketball.team,
    price: Faker::Number.decimal(l_digits: 2),
    status: Faker::Number.between(from: 0, to: 1),
    frequency: Faker::Number.between(from: 0, to: 2),
    tea_id: Tea.all.shuffle.sample.id,
    customer_id: Customer.all.shuffle.sample.id
  })
end