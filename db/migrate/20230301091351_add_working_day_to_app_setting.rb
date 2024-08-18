class AddWorkingDayToAppSetting < ActiveRecord::Migration[7.0]
  def change
    add_column :app_settings, :working_day, :text
  end
end
