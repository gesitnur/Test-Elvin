class CreateInvoices < ActiveRecord::Migration[7.0]
  def change
    create_table :invoices do |t|
      t.string :invoice_code
      t.string :order_number
      t.datetime :invoice_date
      t.datetime :due_date
      t.float :sub_total
      t.float :discount_amount
      t.float :discount_type
      t.float :shipping_charge
      t.float :adjusment
      t.float :total
      t.text :customer_notes
      t.text :term_and_condition
      t.integer :status, default: 0

      t.references :customer
      t.references :sales_person
      t.belongs_to :payment_term

      t.timestamps
    end
  end
end
