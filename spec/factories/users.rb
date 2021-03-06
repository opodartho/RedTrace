FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    sequence(:msisdn, 666_666) { |n| "8801833#{n}" }

    association :company
  end
end
