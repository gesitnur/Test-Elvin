class AddSymbolToCurrency < ActiveRecord::Migration[7.0]
  def change
    add_column :currencies, :symbol, :string
  end
end
