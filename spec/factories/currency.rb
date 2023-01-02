FactoryBot.define do
  factory :currency do
    symbol { Faker::Currency.symbol }
    code { Faker::Currency.code }

    trait :usd do
      symbol { 'US' }
      code { 'USD' }
    end

    trait :brl do
      symbol { 'R$' }
      code { 'BRL' }
    end
  end
end
