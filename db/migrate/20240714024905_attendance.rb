class Attendance < ActiveRecord::Migration[7.0]
  def change
    create_table :attendances do |t|
      t.integer :user_id, null: false
      t.datetime :date, null: false
      t.datetime :checkin_time
      t.datetime :checkout_time
      t.datetime :overtime_start
      t.datetime :overtime_end

      t.timestamps
    end

    add_index :attendances, :user_id
  end
end
