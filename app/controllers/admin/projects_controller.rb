# frozen_string_literal: true

class Admin::ProjectsController < Admin::BaseCrudController
  before_action :data_collection
  # before_action :find_user, only: %i[edit update destroy reset_password approve_leave_request reject_leave_request]

  # def new
  #   @user = User.new
  # end

  # def edit; end

  def create
    super do
      self.redirect_path = admin_projects_path
    end
  end

  def update
    super do
      self.redirect_path = admin_projects_path
    end
  end

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

  def list_user
    @project = Project.find(params[:id])
    @user_project = @project.user_projects.new
    # debugger
    @users = build_select_options(User.project_employee.where.not(id: @project.user_projects.map(&:user_id)))
  end

  def select_user
    @project = Project.find(params[:id])
    @user_project = @project.user_projects.new
    @user_project.user_id = params[:user_project][:user_id]
    @user_project.save

    flash[:notice] = 'Tambah anggota berhasil'
    # redirect_to admin_projects_path
  end

  def destroy_user
    @user_project = UserProject.find(params[:id])
    @user_project.destroy
    flash[:notice] = 'Hapus anggota berhasil'
    redirect_to admin_projects_path
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
