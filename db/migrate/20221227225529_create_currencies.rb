class CreateCurrencies < ActiveRecord::Migration[7.0]
  def change
    create_table :currencies do |t|
      t.string :symbol
      t.string :code

      t.timestamps
    end

    Currency.create(symbol: 'R$', code: 'BRL')
    Currency.create(symbol: '$', code: 'USD')
  end
end
