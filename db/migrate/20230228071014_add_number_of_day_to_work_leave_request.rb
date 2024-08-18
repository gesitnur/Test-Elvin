class AddNumberOfDayToWorkLeaveRequest < ActiveRecord::Migration[7.0]
  def change
    add_column :work_leave_requests, :number_of_day, :integer
  end
end
