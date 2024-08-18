# frozen_string_literal: true

class Invoice < ApplicationRecord
  paginates_per 10

  serialize :customer_data, Hash

  belongs_to :customer
  belongs_to :sales_person, optional: true
  belongs_to :payment_term
  belongs_to :currency

  has_many :invoice_items, dependent: :destroy
  has_many :attachments, dependent: :destroy
  has_many :payments
  accepts_nested_attributes_for :attachments, allow_destroy: true
  accepts_nested_attributes_for :invoice_items, allow_destroy: true

  before_save :generate_customer_data
  before_save :generate_sales_person_name

  enum status: %i[unpaid paid overdue]
  enum term: { 'Net 15': 0, 'Net 30': 1, 'Net 45': 2, 'Net 60': 3, 'Due end of the month': 4,
               'Due end of next month': 4 }

  after_initialize :generate_invoice_code
  after_initialize :generate_payment_term

  scope :get_invoices, ->(company_id) { includes(customer: :company).where(companies: { id: company_id }) }
  scope :status_pendings, -> { where(status: %w[unpaid overdue]) }
  scope :order_desc, -> { order(created_at: :desc) }

  validate :check_due_date
  validates :invoice_code, uniqueness: true

  def invoice_total
    items.map(&:unit_price).sum.to_i
  end

  def generate_payment_term
    self.payment_term ||= PaymentTerm.find_by_name('Due on receipt')
  end

  def generate_invoice_code
    # if Invoice.last.present?
    #   0000
    # end

    test1 = Invoice.maximum('id') || 0
    self.invoice_code ||= format('INV%.6d', (test1 + 1).to_i)
  end

  def check_due_date
    return unless due_date < invoice_date

    errors.add :due_date, ' must be greater than invoice date'
  end

  def pay
    self.status = :paid
    save
  end

  def ship_item?
    goods_item = invoice_items.joins(:item).where(items: { item_type: 'Goods' })
    goods_item.present?
  end

  def generate_customer_data
    self.customer_data = { billing: customer.billing_address.as_json, shipping: customer.shipping_address.as_json,
                           name: customer.display_name }
  end

  def generate_sales_person_name
    self.sales_person_name = sales_person&.name
  end
end

# == Schema Information
#
# Table name: invoices
#
#  id                 :integer          not null, primary key
#  adjusment          :float
#  customer_data      :text
#  customer_notes     :text
#  discount_amount    :float
#  discount_type      :float
#  due_date           :datetime
#  invoice_code       :string
#  invoice_date       :datetime
#  order_number       :string
#  sales_person_name  :string
#  shipping_charge    :float
#  status             :integer          default("unpaid")
#  sub_total          :float
#  term_and_condition :text
#  total              :float
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  currency_id        :integer
#  customer_id        :integer
#  payment_term_id    :integer
#  sales_person_id    :integer
#
# Indexes
#
#  index_invoices_on_currency_id      (currency_id)
#  index_invoices_on_customer_id      (customer_id)
#  index_invoices_on_payment_term_id  (payment_term_id)
#  index_invoices_on_sales_person_id  (sales_person_id)
#
