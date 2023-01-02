FactoryBot.define do
  factory :wallet do
    available_amount { 500 }
    hold_amount { 100 }
    association :currency
    association :user

    trait :usd_currency do
      currency { Currency.find_or_create_by(symbol: 'U$', code: 'USD') }
    end
  end
end
