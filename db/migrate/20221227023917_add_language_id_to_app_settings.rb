class AddLanguageIdToAppSettings < ActiveRecord::Migration[7.0]
  def change
    remove_column :app_settings, :language
    add_column :app_settings, :language_id, :integer
  end
end
