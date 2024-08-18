# frozen_string_literal: true

class Admin::AdminsController < Admin::BaseController
  before_action :data_collection
  before_action :find_admin, only: %i[edit update destroy reset_password]

  def index
    @admins = Admin.all.page(params[:page])
    @domain_accesses = Admin.domain_accesses
    params[:q] ||= {}

    @q = @admins.ransack(params[:q])
    @admins = @q.result.page(params[:page])

    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    @admin = Admin.new
  end

  def edit; end

  def create
    @admin = Admin.new(admin_params)
    @admin.password = Devise.friendly_token(8)
    @admin.generate_login_uniq(admin_params[:name])

    if @admin.save
      flash[:notice] = "Admin successfully created, use #{@admin.password} as password"
      redirect_to admin_admins_path
    else
      flash[:alert] = @admin.errors.full_messages.to_sentence
      render 'new'
    end
  end

  def update
    @admin.generate_login_uniq(admin_params[:name])

    if @admin.update(admin_params)
      flash[:notice] = 'Admin successfully updated'
      redirect_to admin_admins_path
    else
      flash[:alert] = @admin.errors.full_messages.to_sentence
      render 'edit'
    end
  end

  def destroy
    if @admin.destroy
      flash[:notice] = 'Admin successfully destroyed.'
    else
      flash[:alert] = @admin.errors.full_messages.to_sentence
    end

    redirect_to admin_admins_path
  end

  def reset_password
    @admin.password = Devise.friendly_token(8)

    if @admin.save
      flash[:notice] = "Successfully Reset Password. Use #{@admin.password} as password"
    else
      flash[:alert] = @admin.errors.full_messages.to_sentence
    end

    redirect_to admin_admins_path
  end

  private

  def admin_params
    params.require(:admin).permit(:name, :domain_access)
  end

  def data_collection
    @domain_accesses = Admin.domain_accesses.keys.to_a
  end

  def find_admin
    @admin = Admin.find(params[:id])
  end
end
