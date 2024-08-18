class CreateRemainingDayOffs < ActiveRecord::Migration[7.0]
  def change
    create_table :remaining_day_offs do |t|
      t.integer :remaining
      t.integer :year
    end
  end
end
