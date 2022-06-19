FactoryBot.define do
  factory :application, class: 'Doorkeeper::Application' do
    sequence(:name) { |n| "Project #{n}" }
    redirect_uri { '' }
  end
end
