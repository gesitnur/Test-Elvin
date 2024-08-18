class CreateCurrencies < ActiveRecord::Migration[7.0]
  def change
    create_table :currencies do |t|
      t.string :code
      t.belongs_to :country

      t.timestamps
    end
  end
end
