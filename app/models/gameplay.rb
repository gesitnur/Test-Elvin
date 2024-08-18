# frozen_string_literal: true

class Gameplay < ApplicationRecord
  paginates_per 10
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :interview_gameplays, dependent: :destroy
  has_many :interviews, through: :interview_gameplays
  has_many :interview_answers, dependent: :destroy

  has_many :question_multiples, -> { where(question_type: 'Multiple') }, class_name: 'Question', dependent: :destroy
  has_many :question_essays, -> { where(question_type: 'Essay') }, class_name: 'Question', dependent: :destroy

  accepts_nested_attributes_for :question_multiples, allow_destroy: true
  accepts_nested_attributes_for :question_essays, allow_destroy: true

  validates :name, :description, presence: true

  scope :order_by_is_basic, -> { order(is_basic: :desc) }

  after_save :check_questions

  def check_questions
    return true if question_multiples.present? || question_essays.present?

    errors.add(:base, 'Question cannot be blank')
    raise ActiveRecord::RecordInvalid.new(self)
  end

  def basic_gameplay?
    is_basic.eql? true
  end
end

# == Schema Information
#
# Table name: gameplays
#
#  id          :integer          not null, primary key
#  description :text
#  is_basic    :boolean          default(FALSE)
#  name        :string
#  slug        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_gameplays_on_slug  (slug) UNIQUE
#
