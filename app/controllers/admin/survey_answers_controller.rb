# frozen_string_literal: true

class Admin::SurveyAnswersController < Admin::BaseCrudController
  self.additional_parameters = [survey_questions_attributes: [:id, :title, :description, :question_type, {:option => {}}, :_destroy]]

  def index
    @survey = Survey.new.save unless Survey.any?
    @survey = Survey.first

    @question_types = SurveyQuestion.question_types.keys.to_a
    @periods = Survey.periods.keys.to_a
  end

  def show
    @survey = @survey = Survey.first
  end
end
