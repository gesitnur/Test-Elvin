class AddStatusToCurrency < ActiveRecord::Migration[7.0]
  def change
    add_column :currencies, :status, :integer, default: 0
  end
end
