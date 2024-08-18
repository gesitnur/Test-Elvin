# frozen_string_literal: true

class Question < ApplicationRecord
  has_many :interview_answers, dependent: :destroy
  belongs_to :gameplay

  enum question_type: %i[Multiple Essay]
  enum answer: { option_1: 1, option_2: 2, option_3: 3, option_4: 4 }
end

# == Schema Information
#
# Table name: questions
#
#  id            :integer          not null, primary key
#  answer        :integer
#  hint_answer   :text
#  option_1      :string
#  option_2      :string
#  option_3      :string
#  option_4      :string
#  point         :integer
#  question      :text
#  question_type :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  gameplay_id   :integer
#
# Indexes
#
#  index_questions_on_gameplay_id  (gameplay_id)
#
