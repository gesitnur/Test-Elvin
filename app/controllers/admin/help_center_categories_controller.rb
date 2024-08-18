# frozen_string_literal: true

class Admin::HelpCenterCategoriesController < Admin::BaseController

  def index
    @forum_categories = ForumCategory.all.page(params[:page])
  end

  def new
    @forum_category = ForumCategory.new

    respond_to do |format|
      format.js
    end
  end

  def edit
    @forum_category = ForumCategory.find(params[:id])

    respond_to do |format|
      format.js
    end
  end

  def create
    @forum_category = ForumCategory.new(forum_category_params)
    @forum_category.save
    flash[:notice] = 'Category successfully created.'

    respond_to do |format|
      format.js
    end
  end

  def update
    @forum_category = ForumCategory.find(params[:id])
    @forum_category = @forum_category.update(forum_category_params)
    flash[:notice] = 'Category successfully updated.'

    respond_to do |format|
      format.js
    end
  end

  private

  def forum_category_params
    params.require(:forum_category).permit(:name)
  end
end
