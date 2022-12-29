FactoryBot.define do
  factory :offer do
    amount { 20.0 }
    unit_price { 5.2 }
    association :currency_amount, factory: :currency, code: Faker::Currency.code
    association :currency_unit_price, factory: :currency, code: Faker::Currency.code
    association :user
  end
end
