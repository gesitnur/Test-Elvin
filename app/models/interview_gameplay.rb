# frozen_string_literal: true

class InterviewGameplay < ApplicationRecord
  belongs_to :interview
  belongs_to :gameplay

  enum status: {in_progress: 0, completed: 1}
  enum status_scoring: {scoring: 0, rated: 1}

  def completed?
    status.eql?('completed')
  end

  def set_completed
    self.status = :completed
    save
  end

  def set_rated
    self.status_scoring = :rated
    save
  end

  def rated?
    status_scoring.eql?('rated')
  end

  def scoring?
    status_scoring.eql?('scoring')
  end

  def count_total_score
    total_multiple_choice = gameplay.question_multiples.sum(:point)
    total_essay = gameplay.question_essays.sum(:point)
    total_point_question = total_multiple_choice + total_essay

    interview_score = InterviewAnswer.where(interview: interview, gameplay: gameplay).sum(:point)
    self.total_score = (interview_score.to_f * 100) / total_point_question
    save
  end
end

# == Schema Information
#
# Table name: interview_gameplays
#
#  id             :integer          not null, primary key
#  status         :integer          default("in_progress")
#  status_scoring :integer          default("scoring")
#  total_score    :float            default(0.0)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  gameplay_id    :integer
#  interview_id   :integer
#
# Indexes
#
#  index_interview_gameplays_on_gameplay_id   (gameplay_id)
#  index_interview_gameplays_on_interview_id  (interview_id)
#
# Foreign Keys
#
#  gameplay_id   (gameplay_id => gameplays.id)
#  interview_id  (interview_id => interviews.id)
#
