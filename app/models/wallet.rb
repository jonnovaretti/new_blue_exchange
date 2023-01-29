class Wallet < ApplicationRecord
  belongs_to :user
  belongs_to :currency

  validates :available_amount, numericality: { greater_than_or_equal_to: 0, message: 'is not insufficient' }
  validates :available_amount, presence: true

  validates :hold_amount, numericality: { greater_than_or_equal_to: 0 }
  validates :hold_amount, presence: true

  def transfer_amount_to_hold(amount)
    self.available_amount -= amount
    self.hold_amount += amount
  end
end
