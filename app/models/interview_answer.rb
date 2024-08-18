# frozen_string_literal: true

class InterviewAnswer < ApplicationRecord
  belongs_to :interview
  belongs_to :question
  belongs_to :gameplay

  before_save :give_multiple_score

  def give_multiple_score
    return if question.question_type.eql?('Essay')

    return unless answer.eql?(question.answer)

    self.point = question.point
  end
end

# == Schema Information
#
# Table name: interview_answers
#
#  id           :integer          not null, primary key
#  answer       :text
#  point        :integer          default(0)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  gameplay_id  :integer
#  interview_id :integer
#  question_id  :integer
#
# Indexes
#
#  index_interview_answers_on_gameplay_id   (gameplay_id)
#  index_interview_answers_on_interview_id  (interview_id)
#  index_interview_answers_on_question_id   (question_id)
#
# Foreign Keys
#
#  gameplay_id   (gameplay_id => gameplays.id)
#  interview_id  (interview_id => interviews.id)
#  question_id   (question_id => questions.id)
#
