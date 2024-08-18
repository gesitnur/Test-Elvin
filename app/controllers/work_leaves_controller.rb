# frozen_string_literal: true

class WorkLeavesController < ApplicationController
  layout false

  def index; end

  def pending; end

  def accepted; end

  def rejected; end

  def access_denied; end

  def employee_form
    crypt = ActiveSupport::MessageEncryptor.new(Rails.application.secrets.secret_key_base[0..31])

    # begin
      @holidays = []

      all_holidays = CompanyHoliday.all

      all_holidays.each do |holiday|
        (holiday.start_date..holiday.end_date).each { |date| @holidays.push(date_formater date) }
      end

      decrypt_code = crypt.decrypt_and_verify(params[:encrypted_code]).split('+')

      @employee = User.find(decrypt_code.first)
      @leave_request = WorkLeaveRequest.find(decrypt_code.second)

      @leave_types = build_select_options(LeaveType.all)
      @leave_type_collections = LeaveType.all

      if @leave_request.not_filled?
        render 'employee_form'
      elsif @leave_request.pending?
        render 'pending'
      elsif @leave_request.approved?
        render 'accepted'
      elsif @leave_request.rejected?
        render 'rejected'
      end
    # rescue
    #   render 'access_denied'
    # end
  end

  def update
    @leave_request = WorkLeaveRequest.find(params[:id])
    @leave_request.update(update_params)
    @leave_request.check_start_date(update_params[:start_date])
    @leave_request.pending!

    redirect_to form_work_leaves_path(@leave_request.encrypted_code)
  end

  def find_leave_type
    @leave_type = LeaveType.find(params[:leave_type_id])
    @employee = User.find(params[:employee_id])

    @employee_balance = @leave_type.leave_balance - @employee.work_leave_requests.balance_data
                                                             .where(leave_type_id: params[:leave_type_id]).sum(&:number_of_day)

    respond_to do |format|
      format.json { render json: { employee_balance: @employee_balance }, status: 200 }
      format.html
    end
  end

  private

  def update_params
    params.require(:work_leave_request).permit(:leave_type_id, :leave_period, :start_date, :reason, :number_of_day)
  end
end
