class CreateGameplays < ActiveRecord::Migration[7.0]
  def change
    create_table :gameplays do |t|
      t.string :name
      t.text :description
      t.boolean :is_basic, default: false

      t.timestamps
    end
  end
end
