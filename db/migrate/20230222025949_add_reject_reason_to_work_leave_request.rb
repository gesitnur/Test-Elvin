class AddRejectReasonToWorkLeaveRequest < ActiveRecord::Migration[7.0]
  def change
    add_column :work_leave_requests, :reject_reason, :text
  end
end
