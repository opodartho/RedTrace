FactoryBot.define do
  factory :manager do
    username { Faker::Company.ein }
  end
end
