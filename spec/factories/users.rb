FactoryBot.define do
  factory :user, aliases: [:manager] do
    name { Faker::Name.name }
    sequence(:msisdn, 666666) { |n| "8801833#{n}" }
    company
  end
end
