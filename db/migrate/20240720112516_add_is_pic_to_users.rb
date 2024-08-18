class AddIsPicToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :is_pic, :boolean, default: false
  end
end
