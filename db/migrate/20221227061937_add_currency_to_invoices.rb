class AddCurrencyToInvoices < ActiveRecord::Migration[7.0]
  def change
    add_reference :invoices, :currency, index: true
  end
end
