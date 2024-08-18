# frozen_string_literal: true

class User::WorkLeaveRequestsController < ApplicationController
  before_action :authenticate_user!
  include Modules::Crudable
  layout 'owner_layout'

  def index
    @work_leave_requests = WorkLeaveRequest.where(user: current_user).page(params[:page])
  end

  def new
    @leave_request = WorkLeaveRequest.new
    @employee = current_user

    @leave_types = build_select_options(LeaveType.all)
    @leave_type_collections = LeaveType.all
  end

  def create
    # debugger

    # debugger
    @leave_request = WorkLeaveRequest.new(update_params)
    @leave_request.user = current_user
    @leave_request.check_start_date(update_params[:start_date])
    @leave_request.pending!

    if @leave_request.errors.blank?
      flash[:notice] = 'Pengajuan cuti berhasil dibuat'
    else
      # debugger
      flash[:alert] = @leave_request.errors.full_messages.uniq.to_sentence
    end
    redirect_to user_work_leave_requests_path
  end

  def show
    @leave_type_collections = LeaveType.all
  end

  def generate_link; end

  def approve
    @leave_request = WorkLeaveRequest.find(params[:id])
    @leave_request.approved_by = current_user.id
    @leave_request.approval_date = Date.today
    @leave_request.approve

    if @leave_request.save
      flash[:notice] = 'Leave Request Successfully Approved.'
    else
      flash[:alert] = @leave_request.errors.full_messages.to_sentence
    end

    redirect_to user_work_leave_requests_path
  end

  def reject
    @leave_request = WorkLeaveRequest.find(params[:id])
    @leave_request.reject_reason = params[:reject_reason]
    @leave_request.reject

    if @leave_request.save
      flash[:notice] = 'Leave Request Successfully Rejected.'
    else
      flash[:alert] = @leave_request.errors.full_messages.to_sentence
    end

    redirect_to user_work_leave_requests_path
  end

  def allow_edit
    @leave_request = WorkLeaveRequest.find(params[:id])
    @leave_request.is_editable = true
    @leave_request.not_filled

    if @leave_request.save
      flash[:notice] = 'Leave Request Successfully Mark As Editable.'
    else
      flash[:alert] = @leave_request.errors.full_messages.to_sentence
    end

    redirect_to user_work_leave_requests_path
  end

  def destroy
    @leave_request = WorkLeaveRequest.find(params[:id])
    if @leave_request.destroy
      flash[:notice] = 'Leave Request successfully destroyed.'
    else
      flash[:alert] = @leave_request.errors.full_messages.to_sentence
    end

    redirect_to user_work_leave_requests_path
  end



  private

  def update_params
    params.require(:work_leave_request).permit(:leave_type_id, :leave_period, :start_date, :reason, :number_of_day)
  end
end
