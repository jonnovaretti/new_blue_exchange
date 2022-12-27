FactoryBot.define do
  factory :wallet do
    available_amount { 0 }
    hold_amount { 0 }
    currency { 'USD' }
    association :user
  end
end
