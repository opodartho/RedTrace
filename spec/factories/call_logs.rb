FactoryBot.define do
  factory :call_log do
    company
    user
    msisdn { Faker::PhoneNumber.phone_number }
    duration { 20 }
    start_time { Time.zone.now }
    end_time { Time.zone.now }
  end
end
