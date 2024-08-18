class AddLoginToInterview < ActiveRecord::Migration[7.0]
  def change
    add_column :interviews, :encrypted_password, :string
    add_index :interviews, :encrypted_password, unique: true
  end
end
