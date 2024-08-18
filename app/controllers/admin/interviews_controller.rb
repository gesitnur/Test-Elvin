# frozen_string_literal: true

class Admin::InterviewsController < Admin::BaseCrudController

  before_action :data_collection, only: %i[new create edit update change_to_employee]
  before_action :filters_data_collection, only: %i[index]
  self.additional_parameters = [gameplay_ids: []]


  def show
    @encrypt_interview_id = cryptor { |crypt| crypt.encrypt_and_sign(@interview.id) }
  end

  def evaluate_answers
    
  end

  def change_to_employee
    # @user
    @interview = Interview.find(params[:id])

    @user = User.new(
      name: @interview.name,
      email: @interview.email,
      date_of_birth: @interview.date_of_birth,
      address: @interview.domicile,
      graduated: @interview.graduated,
      gender: @interview.gender,
      domicile: @interview.domicile,
      phone_number: @interview.phone_number,
      position_id: Position.last.id,
      password: "12345678"
    )

    if @user.save
      # @interview.destroy
      flash[:notice] = "Berhasil diubah menjadi karyawan"
    else
      flash[:alert] = @user.errors.full_messages
    end


    # Orville Jacobs
    # #<Interview id: 5, name: "Brenden Rojas", graduated: "Quia illo possimus ", major: "In sed sint et volup", 
    # gender: "Woman", date_of_birth: "1983-10-22", apply_for_job: "Frontend", domicile: "Quia possimus ea di", 
    # phone_number: "9901820912", email: "qabujugus@mailinator.com", 
    # scheduled_interview: "2025-02-03 10:51:00.000000000 +0700", work_experience: "Ex excepturi exercit", 
    # is_training: nil, training_duration: nil, fresh_graduated: true, is_trial: nil, trial_duration: nil, 
    # hrd_notes: nil, interview_link: "Ullamco mollit eiusm", notes_before_started: nil,
    #  created_at: "2024-07-23 20:34:55.621168000 +0700", updated_at: "2024-07-23 20:34:55.858299000 +0700", 
    #  login_uniq: "brenden-rojas">

    redirect_to admin_interviews_path
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
