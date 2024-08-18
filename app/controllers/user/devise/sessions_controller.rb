# frozen_string_literal: true

class User::Devise::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  layout 'devise_layout'

  # GET /resource/sign_in
  def new
    @user = User.new

    if tenant_present?(request.subdomain)
      render 'employee'
    else
      render 'company'
    end
  end

  # POST /resource/sign_in
  def create
    user = User.find_by_email(sign_in_params[:email].downcase)
    if user&.valid_password?(sign_in_params[:password])
      if user.email_confirmed
        if user.part_of_company?(request.subdomain)
          sign_in user
          # Apartment::Tenant.switch!(user.company.slug)
          flash[:notice] = 'Signed in successfully.'
        else
          flash[:alert] = 'You are not part of this company'
        end
      else
        flash[:alert] = 'Please activate your account by following the 
        instructions in the account confirmation email you received to proceed'
      end
    else
      flash[:alert] = 'Invalid email/password combination'
    end
    respond_with resource, location: request.referer
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  def after_sign_in_path_for(resource)
    user_attendances_path
  end

  def after_sign_out_path_for(resource_or_scope)
    Apartment::Tenant.switch!('development')
    new_user_session_url
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
