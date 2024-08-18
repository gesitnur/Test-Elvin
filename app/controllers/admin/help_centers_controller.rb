# frozen_string_literal: true

class Admin::HelpCentersController < Admin::BaseController

  def index
    @forums = Forum.all

    if params[:thread].eql?('official')
      @forums = Forum.where(is_admin: true)
    end

    @q = @forums.ransack(params[:q])
    @forums = @q.result.page(params[:page])
    @categories = ForumCategory.all
  end

  def create
    forum = Forum.new(forum_params)
    forum.save

    flash['notice'] = 'Forum successfully created'

    redirect_to admin_help_centers_path
  end

  def show
    @forum = Forum.friendly.find(params[:id])
    @forum_reply = ForumReply.new

    @forum_replies = @forum.forum_replies
  end

  def new
    @forum = Forum.new
    @forum_categories = build_select_options(ForumCategory.all, { label: %i[name], value: :id })
  end

  def edit
    @forum = Forum.friendly.find(params[:id])
    @forum_categories = build_select_options(ForumCategory.all, { label: %i[name], value: :id })
  end

  def update
    forum = Forum.friendly.find(params[:id])
    forum.update(forum_params)

    flash['notice'] = 'Forum successfully updated'

    redirect_to admin_help_centers_path
  end

  def destroy
    forum = Forum.friendly.find(params[:id])
    forum.destroy

    flash['notice'] = 'Forum successfully destroyed'

    redirect_to admin_help_centers_path
  end

  def destroy_reply
    reply = ForumReply.find(params[:reply_id])
    reply.destroy

    flash['notice'] = 'Forum Reply successfully destroyed'

    redirect_to admin_help_center_path
  end

  private

  def forum_params
    f_params = params.require(:forum).permit(:title, :description, :is_admin, :tag, :user_id, :forum_category_id)

    f_params[:tag] = JSON.parse(params[:forum][:tag]).map { |value| value['value'] }.join(', ') if params[:forum][:tag].present?

    f_params
  end
end
