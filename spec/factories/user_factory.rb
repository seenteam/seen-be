FactoryBot.define do
  factory :user do
    user_name { Faker::FunnyName.unique.name }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.unique.email }
    birthday { Faker::Date.birthday(min_age: 18) }
    phone_number { Faker::PhoneNumber.cell_phone }
  end
end
