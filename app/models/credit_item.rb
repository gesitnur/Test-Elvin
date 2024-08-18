# frozen_string_literal: true

class CreditItem < AccountItem
  belongs_to :credit, foreign_key: :account_id

  before_save :create_transaction

  def create_transaction
    return if cash_book_id.blank? || is_initial.eql?(true)

    if self.account_transaction.present?
      transaction = account_transaction
    else
      transaction = Transaction.new
    end

    transaction.transaction_type = account_item_type
    transaction.transaction_date = account_item_date
    transaction.amount = amount
    transaction.description = "Credit Item to #{credit.client}"
    transaction.cash_book = cash_book
    transaction.cash_book_category_id = cash_book_category_id
    transaction.save

    cash_book.update_balance2
    cash_book.save

    self.transaction_id = transaction.id
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
