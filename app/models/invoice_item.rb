# frozen_string_literal: true

class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item, optional: true
  belongs_to :tax_rate, optional: true
end

# == Schema Information
#
# Table name: invoice_items
#
#  id          :integer          not null, primary key
#  amount      :float            default(0.0)
#  description :text
#  name        :string
#  qty         :integer          default(1)
#  rate        :float            default(0.0)
#  tax_amount  :float            default(0.0)
#  invoice_id  :integer
#  item_id     :integer
#  tax_rate_id :integer
#
# Indexes
#
#  index_invoice_items_on_invoice_id   (invoice_id)
#  index_invoice_items_on_item_id      (item_id)
#  index_invoice_items_on_tax_rate_id  (tax_rate_id)
#
