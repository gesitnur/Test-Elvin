class CreateInterviews < ActiveRecord::Migration[7.0]
  def change
    create_table :interviews do |t|
      t.string :name
      t.text :graduated
      t.string :major
      t.integer :gender
      t.date :date_of_birth
      t.integer :apply_for_job
      t.string :domicile
      t.string :phone_number
      t.string :email
      t.datetime :scheduled_interview
      t.text :work_experience
      t.boolean :is_training
      t.integer :training_duration
      t.boolean :fresh_graduated
      t.boolean :is_trial
      t.integer :trial_duration
      t.text :hrd_notes
      t.text :interview_link

      t.text :share_interview_link
      t.text :share_interview_link_for_expert
      t.text :notes_before_started

      t.timestamps
    end
  end
end
