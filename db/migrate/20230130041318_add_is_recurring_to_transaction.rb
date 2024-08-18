class AddIsRecurringToTransaction < ActiveRecord::Migration[7.0]
  def change
    add_column :transactions, :is_recurring, :boolean, default: false
  end
end
