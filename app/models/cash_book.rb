# frozen_string_literal: true

class CashBook < ApplicationRecord
  belongs_to :company
  belongs_to :currency
  has_many :transactions
  has_many :recurrings, dependent: :destroy
  has_many :accounts, dependent: :destroy
  has_many :account_items, dependent: :destroy

  after_create :build_transaction
  after_create :set_default
  before_destroy :check_transactions

  validates :start_balance, presence: true

  def build_transaction
    transaction = transactions.new
    transaction.transaction_type = 'Income'
    transaction.transaction_date = created_at
    transaction.amount = start_balance
    transaction.balance = start_balance
    transaction.description = 'Start Balance'
    transaction.is_editable = false
    transaction.is_start_balance = true
    transaction.save
  end

  def set_default
    return unless CashBook.one?

    self.update(is_default: true)
  end

  def update_balance2
    start = 0
    transactions.order(transaction_date: :asc).each do |transaction|
      next if transaction.is_recurring.eql?(true)

      if transaction.transaction_type.eql?('Income')
        start += transaction.amount
      elsif transaction.transaction_type.eql?('Expense')
        start -= transaction.amount
      else
        if transaction.transfer_to == id
          start += transaction.transfer_to_amount
        elsif transaction.transfer_from == id
          start -= transaction.transfer_from_amount
        end
      end
      transaction.balance = start
      transaction.save(validate: false)
    end

    self.current_balance = start
  end

  def transaction?
    transactions.not_start_balance.present?
  end

  def check_transactions
    return unless transaction?

    errors.add(:cash_book, 'is have transactions data')
    throw(:abort)
  end

  def update_start_balance_transaction(start_balance)
    transaction = transactions.where(is_start_balance: true).first
    transaction.amount = start_balance
    transaction.balance = start_balance
    transaction.save
  end
end

# == Schema Information
#
# Table name: cash_books
#
#  id              :integer          not null, primary key
#  current_balance :float            default(0.0)
#  description     :text
#  is_default      :boolean
#  name            :string
#  start_balance   :float            default(0.0)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  company_id      :integer
#  currency_id     :integer
#
# Indexes
#
#  index_cash_books_on_company_id   (company_id)
#  index_cash_books_on_currency_id  (currency_id)
#
