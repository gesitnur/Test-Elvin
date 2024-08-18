# frozen_string_literal: true

class User::SurveysController < User::BaseController

  def index
    @survey = Survey.first

    @survey_answer = SurveyAnswer.new
  end

  def create
    @survey_answer = SurveyAnswer.new(survey_params)

    if @survey_answer.save
      flash[:notice] = 'survey sent successfully'
    else
      flash[:alert] = @survey_answer.errors.full_messages
    end

    redirect_to user_dashboard_index_path
  end

  private

  def survey_params
    params.permit(:user_id, :survey_id, answer:{})
  end
end
