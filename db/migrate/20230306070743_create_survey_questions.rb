class CreateSurveyQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :survey_questions do |t|
      t.string :title
      t.text :description
      t.integer :question_type
      t.text :option
      t.boolean :is_active

      t.belongs_to :survey
      t.timestamps
    end
  end
end
