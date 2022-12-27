class Currency < ApplicationRecord
  validates :symbol, presence: true

  validates :code, presence: true
  validates_uniqueness_of :code
end
