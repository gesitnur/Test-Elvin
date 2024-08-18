class CreateWorkLeaveRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :work_leave_requests do |t|
      t.integer :leave_type
      t.integer :leave_period
      t.string :status
      t.date :start_date
      t.date :end_date
      t.text :reason
      t.boolean :is_editable, default: true
      t.integer :approved_by
      t.text :encrypted_code
      t.datetime :approval_date
      t.belongs_to :user

      t.timestamps
    end
  end
end
