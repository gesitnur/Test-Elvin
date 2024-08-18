# frozen_string_literal: true

class Interviews::BaseCrudController < ApplicationController
  before_action :authenticate_interview!
  # before_action :switch_tenant_admin
  layout 'interview_layout'
  include Modules::Crudable
end
