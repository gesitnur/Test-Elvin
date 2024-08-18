class AddIsEditableAndIsStartBalanceToTransaction < ActiveRecord::Migration[7.0]
  def change
    add_column :transactions, :is_start_balance, :boolean, default: false
    add_column :transactions, :is_editable, :boolean, default: true
  end
end
