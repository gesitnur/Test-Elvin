# frozen_string_literal: true

class Recurring < ApplicationRecord
  paginates_per 10

  belongs_to :cash_book, optional: true

  enum recurring_type: { 'Expense': 0, 'Transfer': 1 }
  # def 
    
  # end
end

# == Schema Information
#
# Table name: recurrings
#
#  id                    :integer          not null, primary key
#  amount                :float            default(0.0)
#  description           :text
#  recurring_date        :integer
#  recurring_type        :integer
#  transfer_from         :integer          default(0)
#  transfer_from_amount  :float            default(0.0)
#  transfer_to           :integer          default(0)
#  transfer_to_amount    :float            default(0.0)
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  cash_book_category_id :integer
#  cash_book_id          :integer
#
# Indexes
#
#  index_recurrings_on_cash_book_category_id  (cash_book_category_id)
#  index_recurrings_on_cash_book_id           (cash_book_id)
#
