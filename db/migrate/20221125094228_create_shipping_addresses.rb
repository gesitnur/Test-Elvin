class CreateShippingAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :shipping_addresses do |t|
      t.text :attention
      t.text :street1
      t.text :street2
      t.text :zip_code
      t.integer :phone
      t.text :fax
      t.string :city
      t.belongs_to :state
      t.belongs_to :country
      t.belongs_to :customer

      t.timestamps
    end
  end
end
