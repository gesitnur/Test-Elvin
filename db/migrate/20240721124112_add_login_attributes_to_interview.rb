class AddLoginAttributesToInterview < ActiveRecord::Migration[7.0]
  def change
    add_column :interviews, :reset_password_token, :string
    add_column :interviews, :reset_password_sent_at, :datetime
    add_column :interviews, :remember_created_at, :datetime
  end
end
