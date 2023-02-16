FactoryBot.define do
  factory :school do
    school_name { "第一" }
    kind { "中学校" }
    user
    team
  end
end
