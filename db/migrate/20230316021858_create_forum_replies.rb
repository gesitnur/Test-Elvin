class CreateForumReplies < ActiveRecord::Migration[7.0]
  def change
    create_table :forum_replies do |t|
      t.text :message

      t.belongs_to :user
      t.belongs_to :forum
      t.timestamps
    end
  end
end
