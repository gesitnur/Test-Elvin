# frozen_string_literal: true

class Item < ApplicationRecord
  paginates_per 10

  belongs_to :company

  has_one :sales_information
  has_one :purchase_information
  accepts_nested_attributes_for :sales_information
  accepts_nested_attributes_for :purchase_information
  belongs_to :tax_rate, optional: true
  belongs_to :currency

  enum item_type: { 'Goods': 0, 'Service': 1 }
  enum unit: { 'box': 0, 'dz': 1, 'cm': 2, 'ft': 3, 'g': 4, 'in': 5, 'kg': 6 }

  scope :order_desc, -> { order(created_at: :desc) }
end

# == Schema Information
#
# Table name: items
#
#  id          :integer          not null, primary key
#  description :text
#  item_type   :integer
#  name        :string
#  price       :float
#  unit        :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  company_id  :integer
#  currency_id :integer
#  tax_rate_id :integer
#
# Indexes
#
#  index_items_on_company_id   (company_id)
#  index_items_on_currency_id  (currency_id)
#  index_items_on_tax_rate_id  (tax_rate_id)
#
