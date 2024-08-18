# frozen_string_literal: true

class CashBookCategory < ApplicationRecord
  enum category_type: { 'Income': 0, 'Expense': 1 }

  has_many :transactions

  scope :income, -> { where(category_type: 'Income') }
  scope :expense, -> { where(category_type: 'Expense') }
end

# == Schema Information
#
# Table name: cash_book_categories
#
#  id            :integer          not null, primary key
#  category_type :integer
#  name          :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  company_id    :integer
#
# Indexes
#
#  index_cash_book_categories_on_company_id  (company_id)
#
