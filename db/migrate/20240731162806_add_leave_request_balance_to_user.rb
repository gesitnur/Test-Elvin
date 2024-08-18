class AddLeaveRequestBalanceToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :leave_request_balance, :integer, default: 0
  end
end
