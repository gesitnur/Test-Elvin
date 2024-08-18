class CreateContactRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :contact_requests do |t|
      t.string :name
      t.string :email
      t.string :subject
      t.text :message
      t.integer :domain_request
      t.boolean :read, default: false

      t.timestamps
    end
  end
end
