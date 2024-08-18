class CreateForums < ActiveRecord::Migration[7.0]
  def change
    create_table :forums do |t|
      t.string :title
      t.text :description
      t.boolean :is_admin, default: false
      t.string :tag
      t.string :slug

      t.belongs_to :user
      t.belongs_to :forum_category
      t.timestamps
    end
  end
end
