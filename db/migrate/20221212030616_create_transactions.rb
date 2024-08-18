class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.integer :transaction_type
      t.datetime :transaction_date
      t.float :amount, default: 0
      t.text :description
      t.float :balance, default: 0
      t.integer :transfer_from, default: 0
      t.integer :transfer_to, default: 0
      t.integer :transfer_ref

      t.belongs_to :cash_book
      t.belongs_to :cash_book_category

      t.timestamps
    end
  end
end
