class AddRecurringDateToTransaction < ActiveRecord::Migration[7.0]
  def change
    add_column :transactions, :transfer_to_amount, :float, default: 0
    add_column :transactions, :transfer_from_amount, :float, default: 0
    add_column :transactions, :recurring_date, :integer
  end
end
