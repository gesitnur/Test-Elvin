# frozen_string_literal: true

class Debt < Account
  has_many :debt_items, foreign_key: :account_id, dependent: :destroy


  before_create :init_balance
  # before_update :init_balance

  def init_balance
    self.balance = amount
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
