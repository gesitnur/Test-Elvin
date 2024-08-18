# frozen_string_literal: true

class Admin::BaseController < ApplicationController
  before_action :authenticate_admin!
  before_action :switch_tenant_admin
  layout 'admin_layout'
end
