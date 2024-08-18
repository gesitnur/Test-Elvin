# frozen_string_literal: true

class Interview::InterviewsController < ApplicationController
  include Modules::Crudable
  before_action :set_data, only: %i[quest create_answer expert evaluate_answer]

  def quest
    @interview_answers = @interview.interview_answers

    if @interview.completed_gameplay?
      render 'result'
    end
  end

  def create_answer
    params[:answer].each do |_key, answer|
      @interview_answer = InterviewAnswer.create(answer_params(answer))
    end

    if @interview_answer.errors.present?
      flash[:alert] = @interview_answer.errors.full_messages.to_sentence
    else
      @interview.set_completed_gameplay
    end

    redirect_to interview_new_answers_path(params[:interview_id])
  end

  def expert
    @gameplay = Gameplay.friendly.find(params[:gameplay_id])
    @interview_gameplay = @interview.interview_gameplays.find_by(gameplay: @gameplay)
    @interview_answers = @interview.interview_answers

    return if @interview_gameplay.completed?

    flash[:alert] = 'cannot access this link'
    redirect_to '/'
  end

  def evaluate_answer
    @gameplay = Gameplay.friendly.find(params[:gameplay_id])
    @interview_gameplay = @interview.interview_gameplays.find_by(gameplay: @gameplay)

    params[:question].each do |_key, question|
      interview_answer = InterviewAnswer.find(question[:id])
      interview_answer.update(point: question[:point])
    end

    @interview_gameplay.count_total_score
    @interview_gameplay.set_rated

    redirect_to interview_evaluate_answers_path(params[:gameplay_id], params[:interview_id])
  end

  private

  def set_data
    @interview = Interview.find(cryptor { |crypt| crypt.decrypt_and_verify(params[:interview_id]) })
  end

  def answer_params(answers)
    answers.permit(:question_id, :interview_id, :gameplay_id, :answer, :point)
  end
end
