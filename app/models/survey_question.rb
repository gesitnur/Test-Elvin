# frozen_string_literal: true

class SurveyQuestion < ApplicationRecord
	belongs_to :survey

  enum question_type: { 'Text': 1, 'Range 1 - 10': 2, 'Custom Option': 3 }

  # add before action, kalau selain custom option, optionnya dikosongin

  before_save :check_question_type

  serialize :option, Hash

  def check_question_type
    unless question_type.eql?('Custom Option')
      self.option = {}
    end
  end
end

# == Schema Information
#
# Table name: survey_questions
#
#  id            :integer          not null, primary key
#  description   :text
#  is_active     :boolean
#  option        :text
#  question      :string
#  question_type :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  survey_id     :integer
#
# Indexes
#
#  index_survey_questions_on_survey_id  (survey_id)
#
