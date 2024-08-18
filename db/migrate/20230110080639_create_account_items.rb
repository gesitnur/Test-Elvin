class CreateAccountItems < ActiveRecord::Migration[7.0]
  def change
    create_table :account_items do |t|
      t.datetime :account_item_date
      t.integer :account_item_type, default: 0
      t.string :type
      t.float :amount, default: 0
      t.float :balance, default: 0
      t.text :description

      t.belongs_to :account
      t.belongs_to :cash_book
      t.belongs_to :cash_book_category
      t.belongs_to :transaction

      t.timestamps
    end
  end
end
