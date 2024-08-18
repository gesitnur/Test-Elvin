class AddedReplacementUserToWorkLeaveRequests < ActiveRecord::Migration[7.0]
  def change
    add_column :work_leave_requests, :replacement_user_id, :integer
  end
end
