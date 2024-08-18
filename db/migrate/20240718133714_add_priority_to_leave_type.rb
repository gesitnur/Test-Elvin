class AddPriorityToLeaveType < ActiveRecord::Migration[7.0]
  def change
    change_table :leave_types do |t|
      t.integer :priority, default: 0
    end
  end
end
