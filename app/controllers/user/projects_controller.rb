# frozen_string_literal: true

class User::ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_users, only: %i[edit update destroy reset_password]

  include Modules::Crudable
  layout 'owner_layout'

  def load_users
    @users = User.all
  end

  def list_user
    # debugger
    @project = Project.find(params[:id])
    @user_project = @project.user_projects.new
    # debugger
    @users = build_select_options(User.where.not(id: @project.user_projects.map(&:user_id)))

    # UserProject
  end

  def select_user
    # debugger
    @project = Project.find(params[:id])
    @user_project = @project.user_projects.new
    @user_project.user_id = params[:user_project][:user_id]
    @user_project.save
  end

  def destroy_user
    @user_project = UserProject.find(params[:id])
    @user_project.destroy
  end
end
