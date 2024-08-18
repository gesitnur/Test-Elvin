class AddCurrencyToCashBooks < ActiveRecord::Migration[7.0]
  def change
    add_reference :cash_books, :currency, index: true
  end
end
