# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    # return unless tenant_present?(request.subdomain)

    # @company = Company.find_by_slug(Apartment::Tenant.current)
    # @website_setting = if @company.website_setting.blank?
    #                      WebsiteSetting.find_by_company_id(nil)
    #                    else
    #                      @company.website_setting
    #                    end
    # render 'company_index'

    redirect_to new_user_session_path
  end
end
