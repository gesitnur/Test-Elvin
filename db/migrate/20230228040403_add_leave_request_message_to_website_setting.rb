class AddLeaveRequestMessageToWebsiteSetting < ActiveRecord::Migration[7.0]
  def change
    add_column :website_settings, :pending_leave_request_message, :text
    add_column :website_settings, :accepted_leave_request_message, :text
    add_column :website_settings, :rejected_leave_request_message, :text
  end
end
