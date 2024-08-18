class CreatePaymentTerms < ActiveRecord::Migration[7.0]
  def change
    create_table :payment_terms do |t|
      t.string :name
      t.integer :number_of_day
      t.boolean :is_master, default: false

      t.timestamps
    end
  end
end
