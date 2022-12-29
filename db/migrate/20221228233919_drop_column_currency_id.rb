class DropColumnCurrencyId < ActiveRecord::Migration[7.0]
  def change
    remove_column :offers, :currency_id
  end
end
