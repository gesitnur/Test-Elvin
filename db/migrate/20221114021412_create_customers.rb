class CreateCustomers < ActiveRecord::Migration[7.0]
  def change
    create_table :customers do |t|
      t.integer :customer_type
      t.integer :salutation
      t.text :first_name
      t.text :last_name
      t.text :company_name
      t.text :display_name
      t.text :email
      t.text :phone
      t.text :website
      t.string :facebook
      t.string :twitter
      t.text :tax_rate
      t.boolean :enable_portal
      t.integer :portal_language
      t.text :bill_address
      t.text :ship_address
      t.text :remark
      t.float :balance

      t.belongs_to :payment_term
      t.references :company
      t.references :currency

      t.timestamps
    end
  end
end
