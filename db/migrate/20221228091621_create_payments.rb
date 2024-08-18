class CreatePayments < ActiveRecord::Migration[7.0]
  def change
    create_table :payments do |t|
      t.integer :payment_mode, default: 0
      t.datetime :payment_date
      t.text :description
      t.float :amount_received, default: 0

      t.belongs_to :currency
      t.belongs_to :invoice
      t.belongs_to :transaction
      t.timestamps
    end
  end
end
