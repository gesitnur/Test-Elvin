class AddCustomerDataAndSalesPersonDataToInvoices < ActiveRecord::Migration[7.0]
  def change
    add_column :invoices, :customer_data, :text
    add_column :invoices, :sales_person_name, :string
  end
end
