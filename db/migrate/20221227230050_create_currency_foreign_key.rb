class CreateCurrencyForeignKey < ActiveRecord::Migration[7.0]
  def change
    add_column :wallets, :currency_id, :bigint, null: false
    add_foreign_key :wallets, :currencies, column: :currency_id, index: true
    add_index :wallets, [:id, :currency_id], unique: true
  end
end
