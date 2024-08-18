class CreateWebsiteSettings < ActiveRecord::Migration[7.0]
  def change
    create_table :website_settings do |t|
      t.string :coming_soon_title
      t.text :coming_soon_description
      t.references :company

      t.timestamps
    end
  end
end
