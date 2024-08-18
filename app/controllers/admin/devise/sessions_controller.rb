# frozen_string_literal: true

class Admin::Devise::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [:create]
  before_action :switch_tenant
  layout 'devise_layout'

  # GET /resource/sign_in
  def new
    @admin = Admin.new
  end

  # POST /resource/sign_in
  def create
    admin = Admin.find_by_login_uniq(sign_in_params[:login_uniq])

    if admin&.valid_password?(sign_in_params[:password]) && admin&.check_access(request.domain)
      sign_in admin
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
    admin_users_path
  end

  def after_sign_out_path_for(resource_or_scope)
    new_admin_session_url
  end

  def switch_tenant
    Apartment::Tenant.switch!('development')
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:login_uniq])
  end
end
