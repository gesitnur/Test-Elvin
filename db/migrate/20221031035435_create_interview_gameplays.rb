class CreateInterviewGameplays < ActiveRecord::Migration[7.0]
  def change
    create_table :interview_gameplays do |t|
      t.integer :status, default: 0
      t.integer :status_scoring, default: 0
      t.float :total_score, default: 0
      t.references :interview, foreign_key: true
      t.references :gameplay, foreign_key: true

      t.timestamps
    end
  end
end
