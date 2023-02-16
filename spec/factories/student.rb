FactoryBot.define do
  factory :student do
    student_name { Faker::Name.name }
    student_kana { "イチロウ" }
    student_club { "所属なし" }
    student_others { Faker::Lorem.characters(number:4) }
    user
    team
  end
end
