class CreateRecurrings < ActiveRecord::Migration[7.0]
  def change
    create_table :recurrings do |t|
      t.integer :recurring_type
      t.float :amount, default: 0
      t.text :description
      t.integer :transfer_from, default: 0
      t.integer :transfer_to, default: 0
      t.float :transfer_to_amount, default: 0
      t.float :transfer_from_amount, default: 0

      t.belongs_to :cash_book
      t.belongs_to :cash_book_category

      t.timestamps
    end
  end
end
