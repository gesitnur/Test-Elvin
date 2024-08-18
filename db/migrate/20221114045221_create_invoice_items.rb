class CreateInvoiceItems < ActiveRecord::Migration[7.0]
  def change
    create_table :invoice_items do |t|
      t.references :invoice
      t.references :item
      t.string :name
      t.text :description
      t.integer :qty, default: 1
      t.float :rate, default: 0
      t.float :tax_amount, default: 0
      t.references :tax_rate
      t.float :amount, default: 0
    end
  end
end
