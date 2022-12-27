FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { '1234567' }
    confirmed_at { DateTime.now.utc }
  end
end
