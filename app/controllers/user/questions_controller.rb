# frozen_string_literal: true

class User::QuestionsController < ApplicationController
  layout 'help_center_layout'

  def index
    @forums = Forum.where(is_admin: true)

    if params[:filter].eql?('all')
      @forums = Forum.all
    elsif params[:filter].eql?('usefull')
      @forums = Forum.order(cached_votes_total: :desc)
    elsif params[:filter].eql?('popular')
      @forums = Forum.sort_by_popularity
    end

    @q = @forums.ransack(params[:q])
    @sort = params[:sort]
    if @sort.present?
      @q.sorts = "title #{@sort}" if @q.sorts.empty?
    end
    @forums = @q.result.page(params[:page])
    @categories = ForumCategory.all
  end

  def new
    @forum = Forum.new
    @forum_categories = build_select_options(ForumCategory.all, { label: %i[name], value: :id })
  end

  def edit
    @forum = Forum.friendly.find(params[:id])
    @forum_categories = build_select_options(ForumCategory.all, { label: %i[name], value: :id })
  end

  def show
    @forum = Forum.friendly.find(params[:id])
    @forum_reply = ForumReply.new

    @forum_replies = @forum.forum_replies
  end

  def count_view
    @forum = Forum.friendly.find(params[:id])
    @forum.punch(1)

    redirect_to user_help_question_path(@forum)
  end

  def upvote
    @forum = Forum.friendly.find(params[:id])

    if current_user.voted_for? @forum
      @forum.unvote_by current_user
    else
      @forum.upvote_by current_user
    end

    respond_to do |format|
      format.js
    end
  end

  def create
    forum = Forum.new(forum_params)
    forum.save

    flash['notice'] = 'Forum successfully created'

    redirect_to user_help_questions_path
  end

  def update
    forum = Forum.friendly.find(params[:id])
    forum.update(forum_params)

    redirect_to user_help_questions_path
  end

  def destroy
    @forum = Forum.friendly.find(params[:id])
    @forum.destroy

    flash['notice'] = 'Forum successfully destroyed'

    redirect_to user_help_questions_path
  end

  private

  def forum_params
    f_params = params.require(:forum).permit(:title, :description, :is_admin, :tag, :user_id, :forum_category_id)

    f_params[:tag] = JSON.parse(params[:forum][:tag]).map { |value| value['value'] }.join(', ') if params[:forum][:tag].present?

    f_params
  end
end
