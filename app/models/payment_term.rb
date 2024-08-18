# frozen_string_literal: true

class PaymentTerm < ApplicationRecord
  has_many :invoices
  has_many :customers

  scope :without_master_data, -> { where(is_master: false) }
  scope :without_custom_data, -> { where.not(name: 'Custom') }
end

# == Schema Information
#
# Table name: payment_terms
#
#  id            :integer          not null, primary key
#  is_master     :boolean          default(FALSE)
#  name          :string
#  number_of_day :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
