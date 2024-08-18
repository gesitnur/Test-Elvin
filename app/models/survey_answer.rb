# frozen_string_literal: true

class SurveyAnswer < ApplicationRecord
  belongs_to :user
  belongs_to :survey
  serialize :answer, Hash
end

# == Schema Information
#
# Table name: survey_answers
#
#  id         :integer          not null, primary key
#  answer     :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  survey_id  :integer
#  user_id    :integer
#
# Indexes
#
#  index_survey_answers_on_survey_id  (survey_id)
#  index_survey_answers_on_user_id    (user_id)
#
