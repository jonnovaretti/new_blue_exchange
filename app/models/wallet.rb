class Wallet < ApplicationRecord
  belongs_to :user

  validates :available_amount, numericality: { greater_than_or_equal_to: 0 }
  validates :available_amount, presence: true

  validates :hold_amount, numericality: { greater_than_or_equal_to: 0 }
  validates :hold_amount, presence: true

  validates :currency, presence: true
  validates :currency, inclusion: { in: ['BRL', 'USD'] }
end
