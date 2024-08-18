# frozen_string_literal: true

class User::BaseController < ApplicationController
  before_action :authenticate_user!
  before_action :switch_tenant_user
  layout 'owner_layout'

  before_action :check_survey_period

  def check_survey_period
    period = Survey.first.period

    number_period = if period.eql?('1 Week')
                      7
                    elsif period.eql?('2 Week')
                      14
                    elsif period.eql?('1 Month')
                      30
                    end

    return if controller_name.eql?('surveys')

    if current_user.survey_answers.present?
      last_survey_answer = current_user.survey_answers.last

      last_survey_date = last_survey_answer.created_at.to_date

      if Date.today > (last_survey_date + number_period)
        flash[:alert] = 'You must fill out the survey form first'

        redirect_to user_surveys_path
      end
    else
      if Date.today > (current_user.created_at.to_date + number_period)
        flash[:alert] = 'You must fill out the survey form first'

        redirect_to user_surveys_path
      end
    end
  end
end
