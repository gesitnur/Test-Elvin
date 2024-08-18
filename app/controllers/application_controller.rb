# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include ApplicationHelper
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  helper_method :current_controller_path, :previous_url, :system_setting

  def user_not_authorized
    flash[:alert] = 'You are not authorized to perform this action.'
    redirect_to(request.referrer || '/')
  end

  def previous_url(object = nil, is_default = false)
    back_url   = request.referrer
    object   ||= model if defined?(model)

    if back_url.eql?(request.original_url) || back_url.blank? || is_default
      return polymorphic_url([current_controller_path, object]) if object.present?

      default_root_path
    else
      back_url
    end
  end

  def current_controller_path
    return @current_controller_path unless @current_controller_path.blank?

    splited_class_name = self.class.name.to_s.split('::')
    splited_class_name = [splited_class_name.shift]
    @current_controller_path = splited_class_name.join('_').downcase&.to_sym
    return nil if @current_controller_path.blank?

    @current_controller_path
  end

  def previous_url(object: nil, custom_condition: false)
    back_url   = request.referer
    object   ||= model if defined?(model)
    if back_url.eql?(request.original_url) || back_url.blank? || custom_condition || params[:user_id]
      return polymorphic_url([current_controller_path, object]) if object.present?

      default_root_path
    else
      back_url
    end
  end

  def cryptor
    secret_key_base = Rails.application.secrets.secret_key_base
    crypt           = ActiveSupport::MessageEncryptor.new(secret_key_base[0..31], secret_key_base)
    begin
      yield(crypt) if block_given?
    rescue StandardError
      ''
    end
  end

  def switch_tenant_user
    # Apartment::Tenant.switch!(current_user.company.slug)
  end

  def switch_tenant_admin
    # Apartment::Tenant.switch!('development')
  end
end
