# frozen_string_literal: true

class Admin::SurveysController < Admin::BaseCrudController
  self.additional_parameters = [survey_questions_attributes: [:id, :question, :description, :question_type, {:option => {}}, :_destroy]]

  def index
    @survey = Survey.new.save unless Survey.any?
    @survey = Survey.first

    @question_types = SurveyQuestion.question_types.keys.to_a
    @periods = Survey.periods.keys.to_a
  end

  def update
    super do
      self.redirect_path = admin_survey_answers_path
    end
  end
end
