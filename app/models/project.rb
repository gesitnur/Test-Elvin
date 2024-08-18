# frozen_string_literal: true

class Project < ApplicationRecord
  has_many :user_projects
end

# == Schema Information
#
# Table name: projects
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
