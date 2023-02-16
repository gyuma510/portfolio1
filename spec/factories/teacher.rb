FactoryBot.define do
  factory :teacher do
    teacher_name {Faker::Name.name}
    teacher_position { "教頭" }
    teacher_others { Faker::Lorem.characters(number:2) }
    user
    team
  end
end
