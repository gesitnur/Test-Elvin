# frozen_string_literal: true

class BugReport < ApplicationRecord
 belongs_to :user
 belongs_to :company

 enum :status, [:submitted, :fixed], default: :submitted
end

# == Schema Information
#
# Table name: bug_reports
#
#  id          :integer          not null, primary key
#  description :text
#  status      :integer
#  title       :string
#  url         :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  company_id  :integer
#  user_id     :integer
#
# Indexes
#
#  index_bug_reports_on_company_id  (company_id)
#  index_bug_reports_on_user_id     (user_id)
#
