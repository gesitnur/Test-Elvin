# frozen_string_literal: true

class CompanyHoliday < ApplicationRecord
  paginates_per 10

  belongs_to :company

  validates :name, :start_date, :end_date, presence: true
  validate :end_holiday_date

  def end_holiday_date
    return if end_date >= start_date

    errors.add :end_date, 'must be greater or equal to start date'
  end
end

# == Schema Information
#
# Table name: company_holidays
#
#  id         :integer          not null, primary key
#  end_date   :date
#  name       :string
#  start_date :date
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  company_id :integer
#
# Indexes
#
#  index_company_holidays_on_company_id  (company_id)
#
