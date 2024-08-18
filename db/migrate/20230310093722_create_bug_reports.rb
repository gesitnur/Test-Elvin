class CreateBugReports < ActiveRecord::Migration[7.0]
  def change
    create_table :bug_reports do |t|
      t.string :title
      t.text :description
      t.string :url
      t.integer :status

      t.belongs_to :user
      t.belongs_to :company

      t.timestamps
    end
  end
end
