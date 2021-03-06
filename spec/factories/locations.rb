FactoryBot.define do
  factory :location do
    company
    user
    longitude { Faker::Address.longitude }
    latitude { Faker::Address.latitude }
    tracked_at { Time.zone.now }
  end
end
