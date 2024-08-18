class UpdateSurveyQuestionTable < ActiveRecord::Migration[7.0]
  def change
    rename_column :survey_questions, :title, :question
  end
end
