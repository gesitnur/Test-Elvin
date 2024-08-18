class UpdateUserTable < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :address, :text
    add_column :users, :nik, :string
    add_column :users, :npwp, :string
  end
end
