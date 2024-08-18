# frozen_string_literal: true

class User::AttendancesController < User::BaseCrudController
  before_action :data_collection
  before_action :find_user, only: %i[edit update destroy reset_password approve_leave_request reject_leave_request]

  # def new
  #   @user = User.new
  # end

  # def edit; end

  # def create
  #   @user = User.new(user_params)

  #   if @user.save
  #     flash[:notice] = 'User successfully created'
  #     redirect_to user_users_path
  #   else
  #     flash[:alert] = @user.errors.full_messages.to_sentence
  #     render 'new'
  #   end
  # end

  # def update
  #   if @user.update(user_params)
  #     flash[:notice] = 'User successfully updated'
  #     redirect_to user_users_path
  #   else
  #     flash[:alert] = @user.errors.full_messages.to_sentence
  #     render 'edit'
  #   end
  # end

  # def destroy
  #   if @user.destroy
  #     flash[:notice] = 'Worker successfully destroyed.'
  #   else
  #     flash[:alert] = @user.errors.full_messages.to_sentence
  #   end

  #   redirect_to user_users_path
  # end

  # def reset_password
  #   @user.password = Devise.friendly_token(8)

  #   if @user.save
  #     flash[:notice] = "Successfully Reset Password. Use #{@user.password} as password"
  #   else
  #     flash[:alert] = @user.errors.full_messages.to_sentence
  #   end

  #   redirect_to user_users_path
  # end

  # def generate_work_leave_link
  #   @work_leave_request = WorkLeaveRequest.new
  #   @work_leave_request.user_id = params[:id]
  #   @work_leave_request.save
  # end

  # def approve_leave_request
  #   @leave_request = WorkLeaveRequest.find(params[:work_leave_request_id])
  #   @leave_request.approved_by = current_user.id
  #   @leave_request.approval_date = Date.today
  #   @leave_request.approve

  #   if @leave_request.save
  #     flash[:notice] = 'Leave Request Successfully Approved.'
  #   else
  #     flash[:alert] = @leave_request.errors.full_messages.to_sentence
  #   end

  #   redirect_to user_user_path
  # end

  # def reject_leave_request
  #   @leave_request = WorkLeaveRequest.find(params[:work_leave_request_id])
  #   @leave_request.reject_reason = params[:reject_reason]
  #   @leave_request.reject

  #   if @leave_request.save
  #     flash[:notice] = 'Leave Request Successfully Rejected.'
  #   else
  #     flash[:alert] = @leave_request.errors.full_messages.to_sentence
  #   end

  #   redirect_to user_user_path
  # end

  # def allow_edit_leave_request
  #   @leave_request = WorkLeaveRequest.find(params[:work_leave_request_id])
  #   @leave_request.is_editable = true
  #   @leave_request.not_filled

  #   if @leave_request.save
  #     flash[:notice] = 'Leave Request Successfully Mark As Editable.'
  #   else
  #     flash[:alert] = @leave_request.errors.full_messages.to_sentence
  #   end

  #   redirect_to user_user_path
  # end

  # def destroy_leave_request
  #   @leave_request = WorkLeaveRequest.find(params[:work_leave_request_id])

  #   if @leave_request.destroy
  #     flash[:notice] = 'Leave Request successfully destroyed.'
  #   else
  #     flash[:alert] = @leave_request.errors.full_messages.to_sentence
  #   end

  #   redirect_to user_user_path
  # end

  def attendance_in
    attendance = Attendance.find_or_initialize_by(user_id: current_user.id, date: Time.now.to_date)
    attendance.checkin_time = Time.now
    attendance.save
    redirect_to user_attendances_path
    flash[:notice] = "Presensi Masuk Berhasil"
    # debugger
  end

  def attendance_out
    # debugger
    attendance = Attendance.where(date: Date.today.beginning_of_day..Date.today.end_of_day).first
    attendance.checkout_time = Time.now
    attendance.save
    redirect_to user_attendances_path
    flash[:notice] = "Presensi Pulang Berhasil"
  end

  def overtime_in
    attendance = Attendance.where(date: Date.today.beginning_of_day..Date.today.end_of_day).first
    attendance.overtime_start = Time.now
    attendance.save
    redirect_to user_attendances_path
    flash[:notice] = "Mulai lembur Berhasil"
  end

  def overtime_out
    attendance = Attendance.where(date: Date.today.beginning_of_day..Date.today.end_of_day).first
    if Time.now < attendance.overtime_start + 1.hour
      attendance.overtime_start = nil
      flash[:notice] = "Data Lembur Berhasil Dihapus"
    else
      attendance.overtime_end = Time.now
      flash[:notice] = "Selesai Lembur Berhasil"
    end

    attendance.save
    redirect_to user_attendances_path
  end

  private

  # def find_user
  #   @user = User.find(params[:id])
  # end

  # def user_params
  #   params.require(:user).permit(:name, :email, :password, :position_id, :email_confirmed, :company_id)
  # end

  def data_collection
    @dates = Date.today.beginning_of_month..Date.today
    # @attendances = Attendance.all
    #                      .map { |position| [position.name, position.id] }
  end
end
