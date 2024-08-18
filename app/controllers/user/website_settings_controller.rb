# frozen_string_literal: true

class User::WebsiteSettingsController < User::BaseController
  before_action :find_company
  before_action :find_website_setting

  def show; end

  def edit
    authorize @website_setting
  end

  def update
    if @company.website_setting.blank?
      @website_setting = @company.build_website_setting(website_setting_params)
      @website_setting.save
    else
      @website_setting = @company.website_setting.update(website_setting_params)
    end
    flash[:notice] = 'Website Setting successfully updated'

    redirect_to edit_user_website_settings_path
  end

  private

  def find_company
    @company = current_user.company
  end

  def find_website_setting
    @website_setting = if @company.website_setting.blank?
                         WebsiteSetting.find_by_company_id(nil)
                       else
                         @website_setting = @company.website_setting
                       end
  end

  def website_setting_params
    params.require(:website_setting).permit(:coming_soon_title, :coming_soon_description,
                                            :pending_leave_request_message, :accepted_leave_request_message,
                                            :rejected_leave_request_message)
  end
end
