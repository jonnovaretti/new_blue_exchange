class Currency < ApplicationRecord
  validates :symbol, presence: true

  validates :code, presence: true
  validates_uniqueness_of :code

  def self.currency_usd
    Currency.find_by(code: 'USD')
  end

  def self.currency_brl
    Currency.find_by(code: 'BRL')
  end
end
