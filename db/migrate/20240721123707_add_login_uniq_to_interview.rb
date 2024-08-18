class AddLoginUniqToInterview < ActiveRecord::Migration[7.0]
  def change
    add_column :interviews, :login_uniq, :string
    add_index :interviews, :login_uniq, unique: true
  end
end
