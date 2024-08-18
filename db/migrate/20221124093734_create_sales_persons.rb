class CreateSalesPersons < ActiveRecord::Migration[7.0]
  def change
    create_table :sales_persons do |t|
      t.string :name
      t.string :email
      t.references :company

      t.timestamps
    end
  end
end
