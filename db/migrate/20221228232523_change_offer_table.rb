class ChangeOfferTable < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :offers, :currencies, column: :currency_id
    remove_index :offers, name: 'index_offers_on_currency_id'
  end
end
