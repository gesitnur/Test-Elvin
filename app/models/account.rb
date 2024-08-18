# frozen_string_literal: true

class Account < ApplicationRecord
  has_many :account_items, dependent: :destroy
  belongs_to :currency
  belongs_to :cash_book, optional: true
  # belongs_to :transaction
  belongs_to :account_transaction, :class_name => 'Transaction', foreign_key: 'transaction_id', optional: true, dependent: :destroy


  def create_transaction(type, description, cash_book_id)
    return if cash_book_id.blank?

    cash_book = CashBook.find(cash_book_id)
    if self.account_transaction.present?
      transaction = account_transaction
    else
      transaction = Transaction.new
    end

    transaction.transaction_type = type
    transaction.transaction_date = account_date
    transaction.amount = amount
    transaction.description = description
    transaction.cash_book = cash_book
    transaction.cash_book_category_id = cash_book_category_id
    transaction.is_editable = false
    transaction.save

    cash_book.update_balance2
    cash_book.save

    self.transaction_id = transaction.id
  end

  def create_account_item(type)
    if account_items.where(is_initial: true).blank?
      account_item = account_items.new
    else
      account_item = account_items.where(is_initial: true).first
    end

    account_item.account_item_date = account_date
    account_item.type = type
    account_item.amount = amount
    account_item.balance = amount
    account_item.description = description
    account_item.cash_book_id = cash_book&.id
    account_item.cash_book_category_id = cash_book_category_id
    account_item.is_initial = true
    account_item.save
  end

  def calculate_balance
    total = amount
    account_items.order(is_initial: :desc).order(account_item_date: :asc).each do |item|
      next if item.is_initial?
      total += item.amount if item.account_item_type.eql?('Income')
      total -= item.amount if item.account_item_type.eql?('Expense')
      item.balance = total
      item.save
    end
    self.balance = total
    save
  end
end

# == Schema Information
#
# Table name: accounts
#
#  id                    :integer          not null, primary key
#  account_date          :datetime
#  account_type          :integer          default(0)
#  amount                :float            default(0.0)
#  balance               :float            default(0.0)
#  client                :string
#  description           :text
#  due_date              :datetime
#  type                  :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  cash_book_category_id :integer
#  cash_book_id          :integer
#  currency_id           :integer
#  transaction_id        :integer
#
# Indexes
#
#  index_accounts_on_cash_book_category_id  (cash_book_category_id)
#  index_accounts_on_cash_book_id           (cash_book_id)
#  index_accounts_on_currency_id            (currency_id)
#  index_accounts_on_transaction_id         (transaction_id)
#
