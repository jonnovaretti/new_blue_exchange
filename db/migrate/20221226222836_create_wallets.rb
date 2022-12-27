class CreateWallets < ActiveRecord::Migration[7.0]
  def change
    create_table :wallets do |t|
      t.decimal :available_amount, precision: 14, scale: 4, null: false, default: 0
      t.decimal :hold_amount, precision: 14, scale: 4, null: false, default: 0
      t.string :currency, null: false, length: 4
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
