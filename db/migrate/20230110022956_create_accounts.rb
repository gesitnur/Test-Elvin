class CreateAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :accounts do |t|
      t.datetime :account_date
      t.integer :account_type, default: 0
      t.datetime :due_date
      t.string :type
      t.float :amount, default: 0
      t.float :balance, default: 0
      t.string :client
      t.text :description

      t.belongs_to :currency
      t.belongs_to :cash_book
      t.belongs_to :cash_book_category
      t.belongs_to :transaction

      t.timestamps
    end
  end
end


