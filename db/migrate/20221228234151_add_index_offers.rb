class AddIndexOffers < ActiveRecord::Migration[7.0]
  def change
    add_index :offers, [:id, :currency_amount_id, :currency_unit_price_id], unique: true, name: 'index_id_and_currency_amount_and_unit_price_id'
  end
end
