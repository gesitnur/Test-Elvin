# frozen_string_literal: true

class ForumCategory < ApplicationRecord
  has_many :forums
end

# == Schema Information
#
# Table name: forum_categories
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
