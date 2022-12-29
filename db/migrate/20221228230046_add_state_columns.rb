class AddStateColumns < ActiveRecord::Migration[7.0]
  def change
    add_column :offers, :state, :string, null: false, default: 'created'
  end
end
