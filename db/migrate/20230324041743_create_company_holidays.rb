class CreateCompanyHolidays < ActiveRecord::Migration[7.0]
  def change
    create_table :company_holidays do |t|
      t.string :name
      t.date :start_date
      t.date :end_date

      t.belongs_to :company
      t.timestamps
    end
  end
end
