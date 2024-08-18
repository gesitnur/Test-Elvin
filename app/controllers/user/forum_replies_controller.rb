# frozen_string_literal: true

class User::ForumRepliesController < ApplicationController
  def create
    @forum_reply = ForumReply.new(forum_reply_params)
    @forum_reply.save

    @forum = Forum.find(forum_reply_params[:forum_id])
    @forum_replies = @forum.forum_replies
  end

  def update
    @forum_reply = ForumReply.find(params[:id])
    @forum_reply.update(forum_reply_params)

    @forum = Forum.find(forum_reply_params[:forum_id])
    @forum_replies = @forum.forum_replies
  end

  def destroy
    @forum_reply = ForumReply.find(params[:id])
    @forum = @forum_reply.forum

    @forum_replies = @forum.forum_replies
    @forum_reply.destroy
  end

  def vote
    @forum_reply = ForumReply.find(params[:id])

    if current_user.voted_for? @forum_reply
      @forum_reply.unvote_by current_user
    else
      @forum_reply.upvote_by current_user
    end

    @forum = @forum_reply.forum
    @forum_replies = @forum.forum_replies
  end

  def sort
    @forum = Forum.friendly.find(params[:id])

    @forum_replies = if params[:sort].eql?('top')
                       @forum.forum_replies.order(cached_votes_total: :desc)
                     else
                       @forum.forum_replies.order(created_at: :desc)
                     end
  end

  private

  def forum_reply_params
    params.require('forum_reply').permit(:message, :user_id, :forum_id)
  end
end
