class AddCustomerNoteToAppSettings < ActiveRecord::Migration[7.0]
  def change
    add_column :app_settings, :customer_note, :text
  end
end
