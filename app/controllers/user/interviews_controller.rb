# frozen_string_literal: true

class User::InterviewsController < User::BaseCrudController

  before_action :data_collection, only: %i[new create edit update]
  before_action :filters_data_collection, only: %i[index]
  self.additional_parameters = [gameplay_ids: []]


  def show
    @encrypt_interview_id = cryptor { |crypt| crypt.encrypt_and_sign(@interview.id) }
  end

  def evaluate_answers
    @gameplay = Gameplay.find(params[:gameplay_id])
    @interview = Interview.find(params[:id])
    @interview_gameplay = @interview.interview_gameplays.find_by(gameplay: @gameplay)
    @interview_answers = @interview.interview_answers
  end

  def evaluateeee
    # debugger
    @gameplay = Gameplay.find(params[:gameplay_id])
    @interview = Interview.find(params[:id])
    @interview_gameplay = @interview.interview_gameplays.find_by(gameplay: @gameplay)

    params[:question].each do |_key, question|
      interview_answer = InterviewAnswer.find(question[:id])
      interview_answer.update(point: question[:point])
    end

    @interview_gameplay.count_total_score
    @interview_gameplay.set_rated

    redirect_to user_interview_path(@interview)
  end

  private

  def data_collection
    @apply_for_jobs = Interview.apply_for_jobs.keys.to_a
    @gameplays = Gameplay.all
  end

  def filters_data_collection
    @genders = Interview.genders.map { |key, value| [key.humanize, value] }
  end
end
