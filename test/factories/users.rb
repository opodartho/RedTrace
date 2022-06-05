FactoryBot.define do
  factory :user do
    company
    name { "John Doe" }
    msisdn { "8801833182696" }
    password { Devise::Encryptor.digest(User, 'password') }
  end
end
