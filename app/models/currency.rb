# frozen_string_literal: true

class Currency < ApplicationRecord
  paginates_per 10

  belongs_to :country
  has_many :customers
  has_many :app_settings
  has_many :items
  has_many :cash_books
  has_many :invoices
  has_many :payments
  has_many :accounts
  validates :symbol, :code, presence: true
  validates :country, uniqueness: true

  enum status: %i[pending approved]

  def calculate_balance_cash_book(from_date)
    total = 0
    cash_books.each do |cash_book|
      transaction = cash_book.transactions.where('transaction_date < ?', from_date.to_date.beginning_of_day)
                             .order(transaction_date: :asc).last
      if transaction.blank?
        balance = cash_book.start_balance
      else
        balance = transaction.balance
      end
      total += balance
    end

    total
  end
end

# == Schema Information
#
# Table name: currencies
#
#  id         :integer          not null, primary key
#  code       :string
#  status     :integer          default("pending")
#  symbol     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  country_id :integer
#
# Indexes
#
#  index_currencies_on_country_id  (country_id)
#
