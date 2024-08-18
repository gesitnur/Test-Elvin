class CreateCashBookCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :cash_book_categories do |t|
      t.integer :category_type
      t.string :name
      t.references :company

      t.timestamps
    end
  end
end
