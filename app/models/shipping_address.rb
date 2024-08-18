# frozen_string_literal: true

class ShippingAddress < ApplicationRecord
  paginates_per 10

  belongs_to :customer, optional: true
  belongs_to :country, optional: true
  belongs_to :state, optional: true
end

# == Schema Information
#
# Table name: shipping_addresses
#
#  id          :integer          not null, primary key
#  attention   :text
#  city        :string
#  fax         :text
#  phone       :integer
#  street1     :text
#  street2     :text
#  zip_code    :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  country_id  :integer
#  customer_id :integer
#  state_id    :integer
#
# Indexes
#
#  index_shipping_addresses_on_country_id   (country_id)
#  index_shipping_addresses_on_customer_id  (customer_id)
#  index_shipping_addresses_on_state_id     (state_id)
#
