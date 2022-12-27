class DropCurrencyColumn < ActiveRecord::Migration[7.0]
  def change
    remove_column :wallets, :currency
  end
end
