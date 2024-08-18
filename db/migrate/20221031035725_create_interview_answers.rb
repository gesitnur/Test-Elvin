class CreateInterviewAnswers < ActiveRecord::Migration[7.0]
  def change
    create_table :interview_answers do |t|
      t.text :answer
      t.references :interview, foreign_key: true
      t.references :question, foreign_key: true
      t.references :gameplay, foreign_key: true
      t.integer :point, default: 0

      t.timestamps
    end
  end
end
