class RemoveColumnFromInterviews < ActiveRecord::Migration[7.0]
  def change
    remove_column :interviews, :share_interview_link
    remove_column :interviews, :share_interview_link_for_expert
  end
end
