# frozen_string_literal: true

class Interviews::Devise::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [:create]
  layout 'devise_layout'

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    # debugger
    interview = Interview.find_by_login_uniq(sign_in_params[:login_uniq])

    if interview&.valid_password?(sign_in_params[:password])
      sign_in interview
      flash[:notice] = 'Signed in successfully.'
    else
      flash[:alert] = 'Invalid login uniq/password combination'
    end

    respond_with resource, location: request.referer
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  def after_sign_in_path_for(resource)
    interviews_gameplays_path
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:login_uniq])
  end
end
