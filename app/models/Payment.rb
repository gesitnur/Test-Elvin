# frozen_string_literal: true

class Payment < ApplicationRecord
  belongs_to :currency
  belongs_to :invoice
  belongs_to :payment_transaction, :class_name => 'Transaction', foreign_key: 'transaction_id'

  enum payment_mode: { 'Full Payment': 0, 'Partial Payment': 1 }

  validates :description, :payment_date, presence: true
end

# == Schema Information
#
# Table name: payments
#
#  id              :integer          not null, primary key
#  amount_received :float            default(0.0)
#  description     :text
#  payment_date    :datetime
#  payment_mode    :integer          default("Full Payment")
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  currency_id     :integer
#  invoice_id      :integer
#  transaction_id  :integer
#
# Indexes
#
#  index_payments_on_currency_id     (currency_id)
#  index_payments_on_invoice_id      (invoice_id)
#  index_payments_on_transaction_id  (transaction_id)
#
