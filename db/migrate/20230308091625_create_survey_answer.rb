class CreateSurveyAnswer < ActiveRecord::Migration[7.0]
  def change
    create_table :survey_answers do |t|
      t.text :answer

      t.belongs_to :survey
      t.belongs_to :user
      t.timestamps
    end
  end
end
