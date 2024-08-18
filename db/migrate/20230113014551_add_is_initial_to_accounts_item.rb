class AddIsInitialToAccountsItem < ActiveRecord::Migration[7.0]
  def change
    add_column :account_items, :is_initial, :boolean, default: false
  end
end
