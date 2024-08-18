# frozen_string_literal: true

class User::LeaveTypesController < ApplicationController
  before_action :authenticate_user!
  include Modules::Crudable
  layout 'owner_layout'
end
