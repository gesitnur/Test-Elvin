# frozen_string_literal: true

class Survey < ApplicationRecord
  has_many :survey_questions, dependent: :destroy
  accepts_nested_attributes_for :survey_questions, reject_if: :all_blank, allow_destroy: true
  has_many :survey_answers

  enum period: { '1 Week': 1, '2 Week': 2, '1 Month': 3 }
end

# == Schema Information
#
# Table name: surveys
#
#  id          :integer          not null, primary key
#  description :text
#  is_active   :boolean
#  period      :integer
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
