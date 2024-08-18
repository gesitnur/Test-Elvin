class CreateQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :questions do |t|
      t.text :question
      t.integer :question_type
      t.string :option_1
      t.string :option_2
      t.string :option_3
      t.string :option_4
      t.integer :answer
      t.text :hint_answer
      t.integer :point
      t.references :gameplay

      t.timestamps
    end
  end
end
