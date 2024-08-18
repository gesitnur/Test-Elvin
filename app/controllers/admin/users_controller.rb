# frozen_string_literal: true

class Admin::UsersController < Admin::BaseCrudController
  before_action :data_collection
  before_action :find_user, only: %i[edit update destroy reset_password approve_leave_request reject_leave_request
    attendances set_pic contract]

  def index
    @users = User.employee.page(params[:page])
  end

  def new
    @user = User.new
  end

  def edit; end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = 'User successfully created'
      redirect_to admin_users_path
    else
      flash[:alert] = @user.errors.full_messages.to_sentence
      render 'new'
    end
  end

  def update
    if @user.update(user_params)
      flash[:notice] = 'User successfully updated'
      redirect_to admin_users_path
    else
      flash[:alert] = @user.errors.full_messages.to_sentence
      render 'edit'
    end
  end

  def destroy
    if @user.destroy
      flash[:notice] = 'Worker successfully destroyed.'
    else
      flash[:alert] = @user.errors.full_messages.to_sentence
    end

    redirect_to admin_users_path
  end

  def reset_password
    @user.password = Devise.friendly_token(8)

    if @user.save
      flash[:notice] = "Successfully Reset Password. Use #{@user.password} as password"
    else
      flash[:alert] = @user.errors.full_messages.to_sentence
    end

    redirect_to admin_users_path
  end

  def generate_work_leave_link
    @work_leave_request = WorkLeaveRequest.new
    @work_leave_request.user_id = params[:id]
    @work_leave_request.save
  end

  def approve_leave_request
    @leave_request = WorkLeaveRequest.find(params[:work_leave_request_id])
    @leave_request.approved_by = current_user.id
    @leave_request.approval_date = Date.today
    @leave_request.approve

    if @leave_request.save
      flash[:notice] = 'Leave Request Successfully Approved.'
    else
      flash[:alert] = @leave_request.errors.full_messages.to_sentence
    end

    redirect_to user_user_path
  end

  def reject_leave_request
    @leave_request = WorkLeaveRequest.find(params[:work_leave_request_id])
    @leave_request.reject_reason = params[:reject_reason]
    @leave_request.reject

    if @leave_request.save
      flash[:notice] = 'Leave Request Successfully Rejected.'
    else
      flash[:alert] = @leave_request.errors.full_messages.to_sentence
    end

    redirect_to user_user_path
  end

  def allow_edit_leave_request
    @leave_request = WorkLeaveRequest.find(params[:work_leave_request_id])
    @leave_request.is_editable = true
    @leave_request.not_filled

    if @leave_request.save
      flash[:notice] = 'Leave Request Successfully Mark As Editable.'
    else
      flash[:alert] = @leave_request.errors.full_messages.to_sentence
    end

    redirect_to user_user_path
  end

  def destroy_leave_request
    @leave_request = WorkLeaveRequest.find(params[:work_leave_request_id])

    if @leave_request.destroy
      flash[:notice] = 'Leave Request successfully destroyed.'
    else
      flash[:alert] = @leave_request.errors.full_messages.to_sentence
    end

    redirect_to user_user_path
  end

  def attendances
    @dates = Date.today.beginning_of_month..Date.today
    # @user
  end

  def set_attendance_in
    @user = User.find(params[:id])
    # debugger
    attendance = Attendance.where(date: params[:date].to_date.beginning_of_day..params[:date].to_date.end_of_day).first

    if attendance == nil
      attendance = Attendance.find_or_initialize_by(user_id: @user.id, date: params[:date].to_date)
    end

    attendance.checkin_time = params[:datetime].to_datetime - 7.hour
    attendance.user_id = @user.id
    attendance.save

    redirect_to attendances_admin_user_path
    flash[:notice] = "Edit data berhasil"
  end

  def set_attendance_out
    @user = User.find(params[:id])
    # debugger
    attendance = Attendance.where(date: params[:date].to_date.beginning_of_day..params[:date].to_date.end_of_day).first

    if attendance == nil
      attendance = Attendance.find_or_initialize_by(user_id: @user.id, date: params[:date].to_date)
    end

    attendance.checkout_time = params[:datetime].to_datetime - 7.hour
    attendance.user_id = @user.id
    attendance.save

    redirect_to attendances_admin_user_path
    flash[:notice] = "Edit data berhasil"
  end

  def set_overtime_in
    
    @user = User.find(params[:id])
    # debugger
    attendance = Attendance.where(date: params[:date].to_date.beginning_of_day..params[:date].to_date.end_of_day).first

    if attendance == nil
      attendance = Attendance.find_or_initialize_by(user_id: @user.id, date: params[:date].to_date)
    end

    attendance.overtime_start = params[:datetime].to_datetime - 7.hour
    attendance.user_id = @user.id
    attendance.save

    redirect_to attendances_admin_user_path
    flash[:notice] = "Edit data berhasil"
  end

  def set_overtime_out
    
    @user = User.find(params[:id])
    # debugger
    attendance = Attendance.where(date: params[:date].to_date.beginning_of_day..params[:date].to_date.end_of_day).first

    if attendance == nil
      attendance = Attendance.find_or_initialize_by(user_id: @user.id, date: params[:date].to_date)
    end

    attendance.overtime_end = params[:datetime].to_datetime - 7.hour
    attendance.user_id = @user.id
    attendance.save

    redirect_to attendances_admin_user_path
    flash[:notice] = "Edit data berhasil"
  end

  def set_pic
    pic = @user.is_pic? ? false : true
    @user.update(is_pic: pic)
    flash[:notice] = 'User successfully created'

    redirect_to admin_users_path
  end

  def contract
    @contract = if @user.contracts.present?
      @user.contracts.first
    else
      @user.contracts.new
    end
    
  end

  def set_contract
    @user = User.find(contract_params[:user_id])
    @contract = if @user.contracts.present?
      @user.contracts.first
    else
      @user.contracts.new
    end

    if @contract.update(contract_params)
      flash[:notice] = "Edit kontrak berhasil"
    else
      flash[:alert] = @contract.errors.full_messages.to_sentence
    end

    redirect_to admin_users_path
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :position_id, :email_confirmed, :company_id,
      :gender, :date_of_birth, :graduated, :domicile, :phone_number, :addess, :nik, :npwp)
  end

  def contract_params
    params.require(:contract).permit(:user_id, :gaji_pokok, :tunjangan_jabatan, :tunjangan_makan, :tunjangan_transport,
      :tunjangan_laptop, :bpjs_kesehatan, :bpjs_ketenagakerjaan, :pph_21, :periode_slip_gaji)
  end

  def data_collection
    @positions = Position.employee.map { |position| [position.name, position.id] }
  end
end
