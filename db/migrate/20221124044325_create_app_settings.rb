class CreateAppSettings < ActiveRecord::Migration[7.0]
  def change
    create_table :app_settings do |t|
      t.string :company_name
      t.string :company_logo_data
      t.string :company_email
      t.integer :industry
      t.string :street1
      t.string :street2
      t.string :zip_code
      t.string :phone
      t.string :fax
      t.string :website
      t.text :term_and_condition
      t.integer :fiscal_year
      t.integer :start_date
      t.string :report_basis
      t.string :language
      t.string :city
      t.belongs_to :state
      t.belongs_to :country
      t.references :currency
      t.references :company

      t.timestamps
    end
  end
end
