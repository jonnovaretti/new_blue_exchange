class ChangeOfferTableIi < ActiveRecord::Migration[7.0]
  def change
    add_column :offers, :currency_amount_id, :bigint, null: false
    add_column :offers, :currency_unit_price_id, :bigint, null: false

    add_foreign_key :offers, :currencies, column: :currency_amount_id, index: true
    add_foreign_key :offers, :currencies, column: :currency_unit_price_id, index: true

    add_index :offers, [:id, :currency_amount_id]
    add_index :offers, [:id, :currency_unit_price_id]
  end
end
