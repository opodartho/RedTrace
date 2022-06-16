FactoryBot.define do
  factory :company do
    name { Faker::Company.name }
    sequence(:subdomain) { |n| "test-#{n}" }
  end
end
