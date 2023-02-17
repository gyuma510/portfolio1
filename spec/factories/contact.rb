FactoryBot.define do
  factory :contact do
    name { Faker::Name.name }
    content { Faker::Lorem.characters(number:20) }
  end
end
  