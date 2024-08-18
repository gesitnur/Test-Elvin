class UpdateUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :date_of_birth, :date
    add_column :users, :domicile, :string
    add_column :users, :gender, :integer
    add_column :users, :graduated, :text
    add_column :users, :phone_number, :string
  end
end
