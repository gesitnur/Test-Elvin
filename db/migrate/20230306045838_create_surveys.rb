class CreateSurveys < ActiveRecord::Migration[7.0]
  def change
    create_table :surveys do |t|
      t.string :title
      t.text :description
      t.integer :period
      t.boolean :is_active

      t.timestamps
    end
  end
end
