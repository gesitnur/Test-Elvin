class CreateLeaveTypes < ActiveRecord::Migration[7.0]
  def change
    create_table :leave_types do |t|
      t.string :name
      t.boolean :is_active, default: true
      t.integer :leave_balance
      t.integer :position
      t.string :colour_code
      t.belongs_to :company

      t.timestamps
    end
  end
end
