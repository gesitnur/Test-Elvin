module Modules::Crudable
  extend ActiveSupport::Concern

  included do
    class_attribute :additional_parameters
    class_attribute :init_relations
    class_attribute :model_resource
    class_attribute :redirect_path
    class_attribute :render_action
    class_attribute :resource_action
    class_attribute :resource_loads
    class_attribute :resources_action
    class_attribute :resources_query
    class_attribute :order_field
    class_attribute :order_direction
    class_attribute :index_all_records

    self.additional_parameters = []
    self.init_relations        = { has_one: [], has_many: [] }
    self.resource_action       = %w[new show create edit update destroy]
    self.resource_loads        = {}
    self.resources_action      = %w[index export]
    self.resources_query       = {}
    self.redirect_path         = nil
    self.render_action       ||= :new
    self.order_field           = :created_at
    self.order_direction       = :desc
    self.index_all_records     = false

    before_action :get_resource
  end

  def index
    yield if block_given?

    respond_to do |format|
      format.html
      format.json { render json: resources, status: 200 }
      format.js
    end
  end

  def new
    yield if block_given?
    initialize_relations

    respond_to do |format|
      format.html
      format.json { render json: resource, status: 200 }
      format.js
    end
  end

  def create
    yield if block_given?
    respond_to do |format|
      if resource.save
        flash[:notice] ||= "#{resource_name('string')} successfully created."
        # flash[:notice] ||= t('global.alert_successfully_created', model_name: model_name)
        format.html { redirect_to next_redirect_path and return }
        format.json { render json: resource, status: 201 }
      else
        message         = resource&.errors&.full_messages
        flash[:alert] ||= message.present? ? message : 'Failed to create.'
        format.html { render render_action }
        format.json { render error: errors, status: 422 }
      end
      format.js
    end
  end

  def show
    yield if block_given?

    respond_to do |format|
      format.html
      format.json { render json: resource, status: 200 }
      format.js
    end
  end

  def edit
    yield if block_given?
    initialize_relations

    respond_to do |format|
      format.html
      format.json { render json: resource, status: 200 }
      format.js
    end
  end

  def update
    yield if block_given?
    respond_to do |format|
      if resource.update(given_params)
        flash[:notice] ||= "#{resource_name('string')} successfully updated."
        # flash[:notice] ||= t('global.alert_successfully_updated', model_name: model_name)
        format.html { redirect_to next_redirect_path and return }
        format.json { render json: resource, status: 200 }
      else
        message         = resource&.errors&.full_messages
        flash[:alert] ||= message.present? ? message : 'Failed to update.'
        format.html { render :edit }
        format.json { render error: errors, status: 422 }
      end
      format.js
    end
  end

  def destroy
    yield if block_given?

    respond_to do |format|
      if resource.destroy
        flash[:notice] ||= "#{resource_name('string')} successfully destroyed."
        json_response = { content: { redirect_path: next_redirect_path }, status: 200 }
      else
        message         = resource&.errors&.full_messages
        flash[:alert] ||= message.present? ? message : 'Failed to destroy.'
        json_response = { content: { error: resource.errors.full_messages.join(', ') }, status: 403 }
      end

      format.html { redirect_to next_redirect_path and return }
      format.json { render json: json_response[:content], status: json_response[:status] }
      format.js
    end
  end

  private

  def resource
    get_variable(resource_name)
  end

  def resources
    get_variable(resources_name)
  end

  def get_resource
    if mine.resources_action.include?(action_name)
      set_variable(resources_name, load_resources)
    elsif mine.resource_action.include?(action_name)
      set_variable(resource_name, set_resource)
    end
  end

  def load_resources(index_all = index_all_records)
    return eager_loaded_model.order(order_field => order_direction) if index_all || !model.respond_to?(:ransack)

    @q = eager_loaded_model.ransack(params[:q])
    @q.result.order(order_field => order_direction).page(params[:page])
  end

  def object_id
    params[:id] || params["#{resource_name}_id"]
  end

  def get_variable(name)
    instance_variable_get("@#{name}")
  end

  def next_redirect_path
    target_path = mine.redirect_path || redirect_path
    return target_path unless target_path.blank?
    return polymorphic_url([current_controller_path, model]) if %w[destroy export].include?(action_name)

    polymorphic_url([current_controller_path, resource])
  end

  def set_variable(name, value = nil)
    instance_variable_set("@#{name}", value)
  end

  def set_resource
    return model.new(given_params) if %w[new create].include?(action_name)
    return eager_loaded_model.friendly.find(object_id) if model.respond_to?(:friendly)

    eager_loaded_model.find(object_id)
  end

  def initialize_relations
    init_relations[:has_one].each do |relation|
      resource.send("build_#{relation}") if resource.respond_to?("build_#{relation}") && resource.send(relation).blank?
    end

    init_relations[:has_many].each do |relation|
      if resource.send(relation).is_a?(ActiveRecord::Associations::CollectionProxy)
        resource.send(relation).first_or_initialize
      end
    end
  end

  def given_params
    yield if block_given?

    params.require(resource_name).permit(model.column_names, mine.additional_parameters) rescue {}
  end

  def model
    return eval(resource_name.to_s.camelize) unless resource_name.to_s.include?('event')

    model_instance  = model_name.split('_')
    model_namespace = model_instance.shift.capitalize
    model_new_name  = model_instance.join('_').camelize
    eval("#{model_namespace}::#{model_new_name}")
  end

  def model_name
    resource_name('string').downcase.gsub(' ', '_')
  end

  def eager_loaded_model
    if resources_query.present? && resources_action.include?(action_name)
      return model.eager_load(mine.resource_loads).where(resources_query)
    end

    model.eager_load(mine.resource_loads)
  end

  def resource_name(return_format = 'sym')
    mine.model_resource ||= mine.name.gsub('Controller', '').split('::').last.underscore.singularize.to_sym
    return mine.model_resource.to_s.humanize if return_format.eql?('string')

    mine.model_resource
  end

  def resources_name
    resource_name.to_s.pluralize
  end

  def mine
    self.class
  end
end
