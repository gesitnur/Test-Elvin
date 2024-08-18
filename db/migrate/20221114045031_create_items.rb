class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.integer :item_type
      t.string :name
      t.integer :unit
      t.float :price
      t.text :description
      t.belongs_to :tax_rate
      t.belongs_to :company

      t.timestamps
    end
  end
end
