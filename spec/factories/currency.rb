FactoryBot.define do
  factory :currency do
    symbol { Faker::Currency.symbol }
    code { Faker::Currency.code }
  end
end
