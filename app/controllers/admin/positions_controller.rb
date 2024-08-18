# frozen_string_literal: true

class Admin::PositionsController < Admin::BaseCrudController
  before_action :data_collection
  before_action :find_position, only: %i[edit update show_access_detail]
  before_action :set_url, only: %i[edit update]

  def index
    @positions = Position.page(params[:page])
  end

  def new
    @position = Position.new
  end

  def edit; end

  def create
    @position = Position.new(position_params)

    if @position.save
      flash[:notice] = 'Position successfully created'
      redirect_to admin_positions_path
    else
      flash[:alert] = @position.errors.full_messages.to_sentence
      render 'new'
    end
  end

  def update
    if @position.update(position_params)
      flash[:notice] = 'Position successfully updated'
      redirect_to admin_positions_path
    else
      flash[:alert] = @position.errors.full_messages.to_sentence
      render 'edit'
    end
  end

  def show_access_detail; end

  private

  def find_position
    @position = Position.find(params[:id])
  end

  def set_url
    # if @position.company.present?
      @url = admin_position_path(@position)
      @method = 'patch'
    # else
    #   @url = admin_positions_path
    #   @method = 'post'
    # end
  end

  def data_collection
    @hrd_levels = Position::HRD_ACCESS
    @emp_levels = Position::EMP_ACCESS
    @position_types = Position.position_types.keys.to_a
    @position_types.delete('Super Admin')
  end

  def hrd_position_params
    params['hrd'] ||= {}
    hrd_position = Position.hrd_level
    @hrd_levels.each do |hrd_level|
      if params['hrd'][hrd_level].present?
        hrd_position[hrd_level] = Position::CRUD_DATA.key(params['hrd'][hrd_level].map(&:to_sym))
      end
    end
    hrd_position
  end

  def emp_position_params
    params['emp'] ||= {}
    emp_position = Position.emp_level

    @emp_levels.each do |emp_level|
      if params['emp'][emp_level].present?
        emp_position[emp_level] = Position::CRUD_DATA.key(params['emp'][emp_level].map(&:to_sym))
      end
    end
    emp_position
  end

  def position_params
    { name: params[:position][:name], position_type: params[:position][:position_type],
      position_access: { hrd: hrd_position_params, emp: emp_position_params, owner: false },
      company: current_user&.company }
  end
end
