# frozen_string_literal: true

class User::Devise::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :data_collection,          only: %i[new create]
  # before_action :configure_account_update_params, only: [:update]
  layout 'devise_layout'

  # GET /resource/sign_up
  def new
    @user = User.new
    @user.build_company
  end

  # POST /resource
  def create
    @company = Company.new(sign_up_params[:company_attributes])
    @company.save

    @user = User.new(sign_up_params)
    @user.company = @company
    @user.password = Devise.friendly_token(8)

    if @user.save
      UserMailer.registration_confirmation(@user, request.host_with_port).deliver_now
      redirect_to new_user_session_path, notice: 'Successfully Created'
    else
      render :new
    end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(
      :sign_up,
      keys: [
        :name, :position_id, { company_attributes: %i[name address employee_range] }
      ]
    )
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

  def data_collection
    @employee_ranges = Company.employee_ranges.keys.to_a
  end
end
