# frozen_string_literal: true

class Forum < ApplicationRecord
  acts_as_punchable
  acts_as_votable
  paginates_per 10
  extend FriendlyId

  belongs_to :forum_category
  belongs_to :user, optional: true
  has_many :forum_replies, dependent: :destroy

  friendly_id :title, use: :slugged
end

# == Schema Information
#
# Table name: forums
#
#  id                      :integer          not null, primary key
#  cached_votes_down       :integer          default(0)
#  cached_votes_score      :integer          default(0)
#  cached_votes_total      :integer          default(0)
#  cached_votes_up         :integer          default(0)
#  cached_weighted_average :float            default(0.0)
#  cached_weighted_score   :integer          default(0)
#  cached_weighted_total   :integer          default(0)
#  description             :text
#  is_admin                :boolean          default(FALSE)
#  slug                    :string
#  tag                     :string
#  title                   :string
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  forum_category_id       :integer
#  user_id                 :integer
#
# Indexes
#
#  index_forums_on_forum_category_id  (forum_category_id)
#  index_forums_on_user_id            (user_id)
#
