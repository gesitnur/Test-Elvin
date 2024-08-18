# frozen_string_literal: true

class AccountItem < ApplicationRecord
  belongs_to :account
  belongs_to :account_transaction, :class_name => 'Transaction', foreign_key: 'transaction_id', optional: true, dependent: :destroy
  belongs_to :cash_book, optional: true
  # belongs_to :currency

  enum account_item_type: { 'Income': 0, 'Expense': 1 }

  scope :without_initial, -> { where.not(account_item_type: 'initial') }

  def initial
    where(is_initial: true)
  end
end

# == Schema Information
#
# Table name: account_items
#
#  id                    :integer          not null, primary key
#  account_item_date     :datetime
#  account_item_type     :integer          default("Income")
#  amount                :float            default(0.0)
#  balance               :float            default(0.0)
#  description           :text
#  is_initial            :boolean          default(FALSE)
#  type                  :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  account_id            :integer
#  cash_book_category_id :integer
#  cash_book_id          :integer
#  transaction_id        :integer
#
# Indexes
#
#  index_account_items_on_account_id             (account_id)
#  index_account_items_on_cash_book_category_id  (cash_book_category_id)
#  index_account_items_on_cash_book_id           (cash_book_id)
#  index_account_items_on_transaction_id         (transaction_id)
#
