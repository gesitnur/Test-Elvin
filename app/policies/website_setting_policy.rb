# frozen_string_literal: true

class WebsiteSettingPolicy < ApplicationPolicy
  def edit?
    user.position.hrd_company_setting(:update)
  end
end
