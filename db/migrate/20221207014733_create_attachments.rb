class CreateAttachments < ActiveRecord::Migration[7.0]
  def change
    create_table :attachments do |t|
      t.text :attachment_data
      t.string :attachment_type
      t.belongs_to :invoice

      t.timestamps
    end
  end
end
