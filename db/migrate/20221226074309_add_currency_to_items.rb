class AddCurrencyToItems < ActiveRecord::Migration[7.0]
  def change
    add_reference :items, :currency, index: true
  end
end
