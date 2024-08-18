class UserProject < ApplicationRecord
  belongs_to :user
  belongs_to :project
end

# == Schema Information
#
# Table name: user_projects
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  project_id :integer
#  user_id    :integer
#
