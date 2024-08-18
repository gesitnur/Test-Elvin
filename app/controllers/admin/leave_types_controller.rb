# frozen_string_literal: true

class Admin::LeaveTypesController < Admin::BaseCrudController
  # before_action :data_collection
  before_action :find_user, only: %i[edit update destroy reset_password approve_leave_request reject_leave_request]

end
