class AddRecurringDateToRecurrings < ActiveRecord::Migration[7.0]
  def change
    add_column :recurrings, :recurring_date, :integer
  end
end
