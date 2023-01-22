class Offer < ApplicationRecord
  include OfferStateMachine

  belongs_to :user
  belongs_to :currency_amount, class_name: 'Currency'
  belongs_to :currency_unit_price, class_name: 'Currency'

  validates_uniqueness_of :currency_amount_id, scope: [:id, :currency_unit_price_id]
  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 20 }
  validates :unit_price, presence: true, numericality: { greater_than: 4 }

  def total_price
    amount * unit_price
  end
end
