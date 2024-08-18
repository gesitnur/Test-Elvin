# frozen_string_literal: true

class Customer < ApplicationRecord
  paginates_per 10

  # serialize :name, Hash
  serialize :bill_address, Hash
  serialize :ship_address, Hash

  belongs_to :company
  belongs_to :currency
  belongs_to :payment_term

  has_one :billing_address
  accepts_nested_attributes_for :billing_address
  has_one :shipping_address
  accepts_nested_attributes_for :shipping_address

  has_many :invoices

  before_destroy :check_invoices

  accepts_nested_attributes_for :invoices, allow_destroy: true

  enum customer_type: { 'business': 0, 'individual': 1 }
  enum salutation: { 'Mr.': 0, 'Mrs.': 1, 'Ms.': 2, 'Miss.': 3, 'Dr.': 4 }

  scope :order_desc, -> { order(created_at: :desc) }

  def check_invoices
    return unless invoices.present?

    errors.add(:customer, 'is still related to Invoice')
    throw(:abort)
  end
end

# == Schema Information
#
# Table name: customers
#
#  id              :integer          not null, primary key
#  balance         :float
#  bill_address    :text
#  company_name    :text
#  customer_type   :integer
#  display_name    :text
#  email           :text
#  enable_portal   :boolean
#  facebook        :string
#  first_name      :text
#  last_name       :text
#  phone           :text
#  portal_language :integer
#  remark          :text
#  salutation      :integer
#  ship_address    :text
#  tax_rate        :text
#  twitter         :string
#  website         :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  company_id      :integer
#  currency_id     :integer
#  payment_term_id :integer
#
# Indexes
#
#  index_customers_on_company_id       (company_id)
#  index_customers_on_currency_id      (currency_id)
#  index_customers_on_payment_term_id  (payment_term_id)
#
