FactoryBot.define do
  factory :wallet do
    available_amount { 0 }
    hold_amount { 0 }
    association :currency
    association :user
  end
end
