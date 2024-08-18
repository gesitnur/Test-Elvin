# frozen_string_literal: true

class Transaction < ApplicationRecord
  paginates_per 10

  belongs_to :cash_book, optional: true
  belongs_to :cash_book_category, optional: true
  has_one :payment, required: false
  has_one :account, required: false
  has_one :account_item, required: false

  enum transaction_type: { 'Income': 0, 'Expense': 1, 'Transfer': 2 }

  scope :not_start_balance, -> { where(is_start_balance: false) }
  scope :transfer, -> { where(transaction_type: 'Transfer').not_start_balance }
  scope :income, -> { where(transaction_type: 'Income').not_start_balance }
  scope :expense, -> { where(transaction_type: 'Expense').not_start_balance }
  scope :recurring, -> { where(is_recurring: true) }
  scope :not_recurring, -> { where(is_recurring: false) }

  validates :description, :amount, presence: true

  after_update :update_cash_book
  after_create :update_cash_book_balance
  after_destroy :update_balance_after_destroy

  def update_cash_book
    return unless cash_book_previously_changed?
    c = CashBook.find(self.cash_book_id_before_last_save)
    cash_book.update_balance2
    c.update_balance2
    c.save
  end

  def update_cash_book_balance
    return if is_recurring.eql?(true)

    current_balance = if transaction_type.eql?('Income')
                        cash_book.current_balance + amount
                      else
                        cash_book.current_balance - amount
                      end
    self.balance = current_balance
    save
    # end

    cash_book.update_balance2
    cash_book.save
  end

  def update_balance_after_destroy
    cash_book.update_balance2
    cash_book.save
  end

  def self.create_transfer(transaction_params, transfer_from_amount, transfer_to_amount)
    unique_ref = DateTime.now.to_i
    %w[transfer_to transfer_from].each do |field|
      transaction = Transaction.new(transaction_params)
      transaction.cash_book_id = transaction_params[field]
      transaction.transaction_type = 'Transfer'
      transaction.transfer_ref = unique_ref
      transaction.amount = eval("#{field}_amount").tr(',','').to_f
      transaction.save
    end
  end

  def self.update_transfer_data(transaction_params, transaction_data, transfer_from_amount, transfer_to_amount)
    unique_ref = DateTime.now.to_i
    unique = transaction_data.transfer_ref

    %w[transfer_to transfer_from].each do |field|
      new_transaction = transaction_data.deep_clone
      new_transaction.cash_book_id = transaction_params[field]
      new_transaction.transaction_type = 'Transfer'
      new_transaction.transfer_ref = unique_ref
      new_transaction.amount = eval("#{field}_amount").tr(',', '').to_f
      new_transaction.transfer_to = transaction_params['transfer_to']
      new_transaction.transfer_from = transaction_params['transfer_from']
      new_transaction.save
    end
    Transaction.where(transfer_ref: unique).destroy_all
  end

  def self.delete_transfer(transfer_ref)
    transfers = Transaction.transfer.where(transfer_ref: transfer_ref)
    transfers.destroy_all
  end

  def transfer_to_cash_book_name
    CashBook.find(transfer_to).name
  end

  def transfer_from_cash_book_name
    CashBook.find(transfer_from).name
  end
end

# == Schema Information
#
# Table name: transactions
#
#  id                    :integer          not null, primary key
#  amount                :float            default(0.0)
#  balance               :float            default(0.0)
#  description           :text
#  is_editable           :boolean          default(TRUE)
#  is_recurring          :boolean          default(FALSE)
#  is_start_balance      :boolean          default(FALSE)
#  recurring_date        :integer
#  transaction_date      :datetime
#  transaction_type      :integer
#  transfer_from         :integer          default(0)
#  transfer_from_amount  :float            default(0.0)
#  transfer_ref          :integer
#  transfer_to           :integer          default(0)
#  transfer_to_amount    :float            default(0.0)
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  cash_book_category_id :integer
#  cash_book_id          :integer
#
# Indexes
#
#  index_transactions_on_cash_book_category_id  (cash_book_category_id)
#  index_transactions_on_cash_book_id           (cash_book_id)
#
