# frozen_string_literal: true

class ForumReply < ApplicationRecord
  acts_as_votable

  belongs_to :forum
  belongs_to :user
end

# == Schema Information
#
# Table name: forum_replies
#
#  id                      :integer          not null, primary key
#  cached_votes_down       :integer          default(0)
#  cached_votes_score      :integer          default(0)
#  cached_votes_total      :integer          default(0)
#  cached_votes_up         :integer          default(0)
#  cached_weighted_average :float            default(0.0)
#  cached_weighted_score   :integer          default(0)
#  cached_weighted_total   :integer          default(0)
#  message                 :text
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  forum_id                :integer
#  user_id                 :integer
#
# Indexes
#
#  index_forum_replies_on_forum_id  (forum_id)
#  index_forum_replies_on_user_id   (user_id)
#
