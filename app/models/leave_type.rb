# frozen_string_literal: true

class LeaveType < ApplicationRecord
  has_many :work_leave_requests

  enum priority: { low: 0, medium: 1, high: 2 }
end

# == Schema Information
#
# Table name: leave_types
#
#  id            :integer          not null, primary key
#  colour_code   :string
#  is_active     :boolean          default(TRUE)
#  leave_balance :integer
#  name          :string
#  position      :integer
#  priority      :integer          default("low")
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  company_id    :integer
#
# Indexes
#
#  index_leave_types_on_company_id  (company_id)
#
