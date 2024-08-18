class CreateCashBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :cash_books do |t|
      t.string :name
      t.text :description
      t.float :start_balance, default: 0
      t.float :current_balance, default: 0
      t.boolean :is_default
      t.references :company

      t.timestamps
    end
  end
end
