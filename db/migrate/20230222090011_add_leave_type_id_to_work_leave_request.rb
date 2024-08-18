class AddLeaveTypeIdToWorkLeaveRequest < ActiveRecord::Migration[7.0]
  def change
    remove_column :work_leave_requests, :leave_type
    add_reference :work_leave_requests, :leave_type, index: true
  end
end
